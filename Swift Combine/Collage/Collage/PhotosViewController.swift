
import UIKit
import Photos
import Combine

class PhotosViewController: UICollectionViewController {
    
    // MARK: - Public properties
    var selectedPhotos: AnyPublisher<UIImage,Never>{
        return selectedPhotsSubject.eraseToAnyPublisher()
    }
    @Published var selectedPhotoCount = 0
    

    // MARK: - Private properties
    private let selectedPhotsSubject = PassthroughSubject<UIImage,Never>()
    private var subscriptions = Set<AnyCancellable>()

    private lazy var photos = PhotosViewController.loadPhotos()
    private lazy var imageManager = PHCachingImageManager()
    
    private lazy var thumbnailSize: CGSize = {
        let cellSize = (self.collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        return CGSize(width: cellSize.width * UIScreen.main.scale,
                      height: cellSize.height * UIScreen.main.scale)
    }()
    
    // MARK: - View controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check for Photos access authorization and reload the list if authorized.
        PHPhotoLibrary.isAuthorized
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isAuthorized in
                if isAuthorized {
                    self?.photos = PhotosViewController.loadPhotos()
                    self?.collectionView.reloadData()
                }else {
                    self?.showErrorMessage()
                }
            }
            .store(in: &subscriptions)

    }
    
    func showErrorMessage() {
        alert(title: "No access to Camera Roll",
              text: " You can grant access to Collage form the setting app")
            .sink(receiveCompletion: {[weak self] completion in
                self?.dismiss(animated: true, completion: nil)
                self?.navigationController?.popViewController(animated: true)
            }) { _ in}
            .store(in: &subscriptions)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        selectedPhotsSubject.send(completion: .finished)
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = photos.object(at: indexPath.item)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCell
        
        cell.representedAssetIdentifier = asset.localIdentifier
        imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            if cell.representedAssetIdentifier == asset.localIdentifier {
                cell.preview?.image = image
            }
        })
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = photos.object(at: indexPath.item)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell {
            cell.flash()
        }
        
        imageManager.requestImage(for: asset, targetSize: view.frame.size, contentMode: .aspectFill, options: nil, resultHandler: { [weak self] image, info in
            guard let self = self,
                  let image = image,
                  let info = info
            else { return }
            
            if let isThumbnail = info[PHImageResultIsDegradedKey as String] as? Bool, isThumbnail {
                // Skip the thumbnail version of the asset
                return
            }
            
            // Send the selected photo
            self.selectedPhotoCount += 1
            self.selectedPhotsSubject.send(image)
        })
    }
    
}

// MARK: - Fetch assets
extension PhotosViewController {
    
    static func loadPhotos() -> PHFetchResult<PHAsset> {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        return PHAsset.fetchAssets(with: allPhotosOptions)
    }
    
}
