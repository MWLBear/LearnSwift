import UIKit
import Combine

struct MyType:Decodable {
    
}

class MainViewController: UIViewController {
    
    private var subscriptions = Set<AnyCancellable>()
    private var images = CurrentValueSubject<[UIImage],Never>([])
    
    // MARK: - Outlets
    
    @IBOutlet weak var imagePreview: UIImageView! {
        didSet {
            imagePreview.layer.borderColor = UIColor.gray.cgColor
        }
    }
    @IBOutlet weak var buttonClear: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var itemAdd: UIBarButtonItem!
    
    // MARK: - Private properties
    
    
    // MARK: - View controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let collageSize = imagePreview.frame.size
        
        images.handleEvents( receiveOutput: { (photo) in
            self.updateUI(photos: photo)
        })
        .map{ photo in
            UIImage.collage(images: photo, size: collageSize)
        }
        .assign(to: \.image, on: imagePreview)
        .store(in: &subscriptions)
        
        
        
    }
    
    func url() {
        guard let url = URL(string: "") else {
            return
        }
        
        let subscription = URLSession.shared.dataTaskPublisher(for: url)
            .sink(receiveCompletion: { completion in
                
                if case .failure(let error) = completion{
                    print("Retrieving data failed with error \(error)")
                }
            }) { (data ,response) in
                print("Retrieved data of size")
            }
        
        let subscription1 = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MyType.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in if case .failure(let err) = completion {
                  print("Retrieving data failed with error \(err)")
                }
              }, receiveValue: { object in
                print("Retrieved object \(object)")
            })
        
    }
    
    
    func requestshare() {
        let url = URL(string: "https://www.raywenderlich.com")!;
        let publisher = URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .multicast { PassthroughSubject<Data ,URLError>() }
        
        // 2
        let subscription1 = publisher .sink(receiveCompletion: { completion in
        if case .failure(let err) = completion {
              print("Sink1 Retrieving data failed with error \(err)")
            }
          }, receiveValue: { object in
            print("Sink1 Retrieved object \(object)")
        })
        // 3
        let subscription2 = publisher .sink(receiveCompletion: { completion in
        if case .failure(let err) = completion {
              print("Sink2 Retrieving data failed with error \(err)")
            }
          }, receiveValue: { object in
            print("Sink2 Retrieved object \(object)")
        })
        
        let subscription = publisher.connect();
        //使用此代码，您可以一次发送请求，并将结果共享给两个订户。
        
    }
    
    
    
    
    private func updateUI(photos: [UIImage]) {
        buttonSave.isEnabled = photos.count > 0 && photos.count % 2 == 0
        buttonClear.isEnabled = photos.count > 0
        itemAdd.isEnabled = photos.count < 6
        title = photos.count > 0 ? "\(photos.count) photos" : "Collage"
    }
    
    // MARK: - Actions
    
    @IBAction func actionClear() {
        images.send([])
    }
    
    @IBAction func actionSave() {
        guard let image = imagePreview.image else { return }
        
        PhotoWriter.save(image)
            .sink { [unowned self] compltion in
                if case  .failure(let error) = compltion {
                    self.showMessage("Error", description:
                                        error.localizedDescription)
                }
                
            } receiveValue: { [unowned self] id in
                self.showMessage("Saved with id: \(id)")
            }
            .store(in: &subscriptions)
        
    }
    
    @IBAction func actionAdd() {

        let photos = storyboard!.instantiateViewController(identifier: "PhotosViewController") as! PhotosViewController
       
        photos.$selectedPhotoCount
            .filter{$0 > 0}
            .map {"Selected \($0) photos"}
            .assign(to: \.title, on: self)
            .store(in: &subscriptions)
        
        //prefix(while:), 闭包值为真通过,假结束
        let newPhotos = photos.selectedPhotos
            .prefix(while: { [unowned self] _ in
                return self.images.value.count < 6
            })
            .filter{ newImage in
                return newImage.size.width > newImage.size.height}
            .share()//为同一发布者创建多个订阅时的正确方法是通过share（）运算符共享原始发布者。
        
        newPhotos
            .ignoreOutput()
            .filter { [unowned self] _ in
                self.images.value.count == 6
            }
            .flatMap{ [unowned self]  _ in
                self.alert(title: "Limit reached", text: "To add more than 6 photos purchase Collage Pro")
            }
            .sink(receiveCompletion: { [unowned self ] _ in
                self.navigationController?.popViewController(animated: true)
            }) { _ in
                
            }
            .store(in: &subscriptions)
        
            
        newPhotos.map{ [unowned self] newImage in
            return self.images.value + [newImage]
        }.subscribe(images)
        .store(in: &subscriptions)
        
        newPhotos
            .ignoreOutput()
            .delay(for: 2.0, scheduler: DispatchQueue.main)
            .sink { [unowned self] _ in
                self.updateUI(photos: self.images.value)
            } receiveValue: { _ in }
            .store(in: &subscriptions)

        navigationController!.pushViewController(photos, animated: true)
        
    }
    
    private func showMessage(_ title: String, description: String? = nil) {
      alert(title: title, text: description)
        .sink { _ in }
        .store(in: &subscriptions)
    }
}
