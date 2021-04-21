

import UIKit

class TabBarController: UITabBarController {

  private let contactsNavigationController = NavigationController(tabBar: .contacts)
  private let profileNavigationController = NavigationController(tabBar: .profile)
  private let messageTableViewController = NavigationController(tabBar: .message)

    override func viewDidLoad() {
        super.viewDidLoad()
        embedViewControllers()
        // Do any additional setup after loading the view.
    }
  
  // MARK: - UI
  private func embedViewControllers() {
    viewControllers = [
      profileNavigationController,
      contactsNavigationController,
      messageTableViewController
    ]
  }
}

private final class NavigationController:UINavigationController {
  init(tabBar:TabBar) {
 
    super.init(rootViewController: tabBar.viewController)
    tabBarItem.title = tabBar.title
    tabBarItem.image = tabBar.image
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fatalError("init(coder:) has not been implemented")
  }
}
