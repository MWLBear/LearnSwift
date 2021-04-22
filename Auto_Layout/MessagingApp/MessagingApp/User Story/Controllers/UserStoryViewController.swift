
import UIKit

class UserStoryViewController: UIViewController {
  //MRAK: -Properties
  private let userStory: UserStory
  private let cellIdentifier = "cellIdentifier"
  private let headerViewIdentifier = "headerViewIdentifier"
  private var currentItemIndex = 0
  private lazy var flowLayout: UICollectionViewFlowLayout = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    return flowLayout
  }()
  private lazy var swipeDownGesture:UISwipeGestureRecognizer = {
    let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissController))
    swipe.direction = .down
    return swipe
  }()
  private lazy var collectionView: UICollectionView = {
    let collectonView = UICollectionView(frame: .zero,collectionViewLayout: flowLayout)
    collectonView.backgroundColor = .systemBackground
    collectonView.showsHorizontalScrollIndicator = false
    collectonView.isPagingEnabled = true
    collectonView.bounces = false
    collectonView.register(StoryEventCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    collectonView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerViewIdentifier)
    collectonView.delegate = self
    collectonView.dataSource = self
    return collectonView
  }()
  private lazy var storyProgressView = StoryProgressView(itemsCount: userStory.events.count)

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addGestureRecognizer(swipeDownGesture)
    setupCollectionView()
    setupStoryProgesssView()
  }
  
  
  // MARK: - Layouts
  func setupCollectionView() {
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate(
      [collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
       collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
       collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
       collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)]
    )
  }
  
  
  //MRAK: - Initializers
  init(userStory:UserStory) {
    self.userStory = userStory
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .systemBackground
    title = "@\(userStory.username.rawValue)"
    setupNavigationBar()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: UI
  private func setupNavigationBar(){
    let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissController))
    navigationItem.leftBarButtonItem = leftBarButtonItem
  }
  private func setupStoryProgesssView(){
    print("setupStoryProgesssView")
    storyProgressView.delegate = self
    view.addSubview(storyProgressView)
    storyProgressView.translatesAutoresizingMaskIntoConstraints = false
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate(
      [storyProgressView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
       storyProgressView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
       storyProgressView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
       storyProgressView.heightAnchor.constraint(equalToConstant: 32)]
    )
    
  }
  
  @objc private func dismissController(){
    self.dismiss(animated: true, completion: nil)
  }
  
  //MRAK: -scrollView

  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let contentOffsetX = targetContentOffset.pointee.x
    let scorllViewWidth = scrollView.frame.width
    currentItemIndex = Int(contentOffsetX / scorllViewWidth)
  }
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    guard currentItemIndex > 0 else { return }
    storyProgressView.selectedIndex = currentItemIndex - 1
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let xContentOffset = scrollView.contentOffset.x
    let scrollViewWidth = scrollView.frame.width
    guard xContentOffset <= scrollViewWidth else { return }
    storyProgressView.alpha = xContentOffset / scrollViewWidth
  }
  
  private func centerCollcetionViewContent(){
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      let x = self.collectionView.frame.width * CGFloat(self.currentItemIndex)
      let y: CGFloat = 0
      let contentOffset = CGPoint(x: x, y: y)
      
      self.collectionView.setContentOffset(contentOffset, animated: false)
    }
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    centerCollcetionViewContent()
  }
}

extension UserStoryViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return userStory.events.count
  }
  

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? StoryEventCollectionViewCell else  {
      fatalError("error")
    }
    let item = indexPath.item
    cell.configureCell(storyEvent: userStory.events[indexPath.item])
    cell.backgroundColor = item % 2 == 0 ? .lightGray : .darkGray
    return cell
  }
  
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerViewIdentifier, for: indexPath) as? HeaderCollectionReusableView else {
      fatalError("error")
    }
    headerView.configureCell(username: userStory.username)
    return headerView
  }
}

extension UserStoryViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return collectionView.frame.size
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .zero
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return collectionView.frame.size
  }
}

extension UserStoryViewController: StoryProgressViewDelegate {
  func didSelectProgressItem(at indexPath: IndexPath) {
    self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }
}
