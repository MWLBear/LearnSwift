

import UIKit

class TabBarController: UITabBarController {

  private let contactsNavigationController = NavigationController(tabBarTitle: .contacts)
  private let profileNavigationController = NavigationController(tabBarTitle: .profile)
  private let messageTableViewController = NavigationController(tabBarTitle: .message)

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
  init(tabBarTitle:TabBarTitle) {
    let rootViewController:UIViewController
    switch tabBarTitle {
    case .contacts:
      let contactsStoryboard = UIStoryboard(name: "Contacts", bundle: nil)
      let viewController = contactsStoryboard.instantiateViewController(withIdentifier: "ContactListTableViewController")
      rootViewController = viewController

    case .profile:
      rootViewController = ProfileViewController()
    case .message:
      rootViewController = MessagesTableViewController()
    }
    rootViewController.title = tabBarTitle.rawValue
    super.init(rootViewController: rootViewController)
    tabBarItem.title = tabBarTitle.rawValue
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fatalError("init(coder:) has not been implemented")
  }
}
