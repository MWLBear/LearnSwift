
import UIKit

class MessageViewController: UIViewController {
 private let userstories = [
    UserStory(username: .swift),
    UserStory(username: .android),
    UserStory(username: .dog)
  ]
  
  private lazy var miniStoryView = MiniStoryView(userStories: userstories)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupMiniStory()
  }
  private func setupMiniStory(){
    view.addSubview(miniStoryView)
    miniStoryView.backgroundColor = .lightGray
    miniStoryView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      miniStoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      miniStoryView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
      miniStoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      miniStoryView.heightAnchor.constraint(equalToConstant: 80)
    ])
    miniStoryView.delegate = self
  }
  
  
  
}
extension MessageViewController:MiniStoryViewDelegate {
  func didSelectUserStory(atIndex index: Int) {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      let story = self.userstories[index]
      let viewController = UserStoryViewController(userStory: story)
      let navigationController = UINavigationController(rootViewController: viewController)
      navigationController.modalPresentationStyle = .fullScreen
      self.present(navigationController, animated: true)
      
    }
  }
}
