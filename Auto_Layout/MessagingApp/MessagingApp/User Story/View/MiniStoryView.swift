
import UIKit

protocol MiniStoryViewDelegate:class {
  func didSelectUserStory(atIndex index: Int)
}
class MiniStoryView: UIView {
  //MRAK: -Properties
  private let userStories: [UserStory]
  private let cellIdentifier = "cellIdentifier"
  weak var delegate:MiniStoryViewDelegate?
  
  private let verticalInset:CGFloat = 8
  private let horizontalInset:CGFloat = 16
  private lazy var flowLayout: UICollectionViewFlowLayout = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumLineSpacing = 16
    flowLayout.scrollDirection = .horizontal
    flowLayout.sectionInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
    return flowLayout
  }()
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.register(MiniStoryCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = .systemGroupedBackground
    collectionView.dataSource = self
    collectionView.delegate = self
    return collectionView
  }()
  
  init(userStories:[UserStory]) {
    self.userStories = userStories
    super.init(frame: .zero)
    setUpCollectionView()
  }
  
  required init?(coder: NSCoder) {
    self.userStories = []
    super.init(coder: coder)
  }
  
  //MRAK: -Layout
  override func layoutSubviews() {
    super.layoutSubviews()
    let height = collectionView.frame.height - verticalInset * 2
    let width = height
    let itemSize = CGSize(width: width, height: height)
    
    flowLayout.itemSize = itemSize
    
  }
  
  private func setUpCollectionView(){
    addSubview(collectionView)
    collectionView.fillSuperView()
  }

}
//Mark: -UICollectionViewDataSource
extension MiniStoryView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return userStories.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MiniStoryCollectionViewCell else {
      fatalError("Dequeued Unregistered Cell")
    }
    let username = userStories[indexPath.item].username
    cell.configureCell(imageName: username.rawValue)
    return cell
    
  }
}

extension MiniStoryView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.didSelectUserStory(atIndex: indexPath.item)
  }
}
