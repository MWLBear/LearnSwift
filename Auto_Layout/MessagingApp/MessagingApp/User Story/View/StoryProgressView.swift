
import UIKit

protocol StoryProgressViewDelegate: class {
  func didSelectProgressItem(at indexPath: IndexPath)
}
class StoryProgressView: UIView {
  // MARK: - Properties
  private let collectionViewHorizontalInset: CGFloat = 2
  private let collectionViewVerticalInset: CGFloat = 2
  private let lineSpacing: CGFloat = 2
  
  private let selectedBackgroundColor = UIColor.white
  private let deselectedBackgroundColor = UIColor(white: 1, alpha: 0.5)
  
  var selectedIndex: Int = 0 {
    didSet {
      DispatchQueue.main.async { [weak self] in
        self?.collectonView.reloadData()
      }
    }
  }
  
  private lazy var flowLayout: UICollectionViewFlowLayout = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.sectionInset = UIEdgeInsets(top: collectionViewVerticalInset, left: collectionViewHorizontalInset, bottom: collectionViewVerticalInset, right: collectionViewHorizontalInset)
    flowLayout.minimumLineSpacing = lineSpacing
    return flowLayout
  }()
  private lazy var collectonView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = .clear
    return collectionView
  }()
  
  private let cellIdentifier = "cellIdentifier"
  private let itemsCount: Int
  weak var delegate: StoryProgressViewDelegate?
  
  //MRAK: -Initializers
  init(itemsCount:Int) {
    self.itemsCount = itemsCount
    super.init(frame: .zero)
    backgroundColor = UIColor.black.withAlphaComponent(0.7)
    alpha = 0
    setupCollectionView()
  }

  required init?(coder aDecoder: NSCoder) {
    self.itemsCount = 0
    super.init(coder: aDecoder)
  }
  private func setupCollectionView(){
    addSubview(collectonView)
    collectonView.fillSuperView()
    collectonView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    print("setupCollectionView")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    flowLayout.invalidateLayout()
  }
  // MARK: - UI
  func fadeAnimation(isFadeIn: Bool) {
    let alpha: CGFloat = isFadeIn ? 0.8 : 0
    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
      self.alpha = alpha
    }, completion: nil)
  }
}
// MARK: - UICollectionViewDelegate
extension StoryProgressView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedIndex = indexPath.item
    delegate?.didSelectProgressItem(at: indexPath)
  }
}
extension StoryProgressView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return itemsCount
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
    cell.backgroundColor = indexPath.item == selectedIndex
      ? selectedBackgroundColor
      : deselectedBackgroundColor
    return cell
  }
  
  
}
extension StoryProgressView: UICollectionViewDelegateFlowLayout {
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let mitigatedInsetsWidth = collectionView.frame.width - collectionViewHorizontalInset * 2
    let mitigatedLineSpacingWidth = mitigatedInsetsWidth - CGFloat(itemsCount - 1) * lineSpacing
    let width = mitigatedLineSpacingWidth / CGFloat(itemsCount)
    let height = collectionView.frame.height - collectionViewVerticalInset * 2
    return CGSize(width: width, height: height)
  }
}
