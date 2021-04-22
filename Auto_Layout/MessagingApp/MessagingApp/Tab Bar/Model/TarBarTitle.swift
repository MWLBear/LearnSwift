import UIKit

enum TabBar:String {
  case contacts = "Contacts"
  case profile = "Profile"
  case message = "Message"
  case collectoin = "collectoin"
  var viewController: UIViewController  {
    
    let rootViewController: UIViewController
    switch self {
    case .contacts:
      let contactsStoryboard = UIStoryboard(name: "Contacts", bundle: nil)
      let viewController = contactsStoryboard.instantiateViewController(withIdentifier: "ContactListTableViewController")
      rootViewController = viewController
      
    case .profile:
      rootViewController = ProfileViewController()
    case .message:
      rootViewController = MessagesTableViewController()
   
    case .collectoin:
      rootViewController = MessageViewController()
    }
    rootViewController.title = title

    return rootViewController
  }
  var title:String {
    switch self {
    case .contacts:
      return "Contact"
    case .profile:
      return "Profile"
    case .message:
      return "Message"
    case .collectoin:
      return "Collection"
    }
  }
  
  var image: UIImage {
    let systemName: String
    switch self {
    case .contacts:
      systemName = "person.3.fill"
    case .profile:
      systemName = "person.fill"
    case .message:
      systemName = "message.fill"
    case .collectoin:
      systemName = "message.fill"

    }
    guard let image = UIImage(systemName: systemName) else {
      fatalError("Unable to retrieve system image: \(systemName).")
    }
    return image
  }
  
  
}
