
import UIKit

class MessagesTableViewController: UITableViewController {
  
  private let messages = Message.fetchAll()
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
  }
  
  //MRAK: - helper Method
  private func configureTableView() {
    tableView.allowsSelection = false
    tableView.register(LeftMessagebubbleTableViewCell.self, forCellReuseIdentifier: MessageBubbleCellType.leftText.rawValue)
    tableView.register(RightMessageBubbleTableViewCell.self, forCellReuseIdentifier: MessageBubbleCellType.rightText.rawValue)
    tableView.register(LeftMessageImageBubbleTableViewCell.self, forCellReuseIdentifier: ImageBubbleCellType.leftImageText.rawValue)
    tableView.register(RightMessageImageTableViewCell.self, forCellReuseIdentifier: ImageBubbleCellType.rightImageText.rawValue)
    
    tableView.separatorStyle = .none
    tableView.rowHeight = UITableView.automaticDimension
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTap))

  }
  
  @objc func addTap (){
    
//    let viewController = UINavigationController(rootViewController: MessageViewController())
//    viewController.modalPresentationStyle = .fullScreen
//    present(viewController, animated: true, completion: nil)
    
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return messages.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let message = messages[indexPath.row]
    
    if message.imageName != nil {
      var cell: ImageBubbleTableViewCell
      if message.sentByMe {
        cell = tableView.dequeueReusableCell(withIdentifier: ImageBubbleCellType.rightImageText.rawValue,for: indexPath) as! RightMessageImageTableViewCell
      }
      else {
        cell = tableView.dequeueReusableCell(
          withIdentifier: ImageBubbleCellType.leftImageText.rawValue,
          for: indexPath) as! LeftMessageImageBubbleTableViewCell
      }
      if let imageName = message.imageName {
        cell.messageImageView.image = UIImage(named: imageName)
      }
      cell.messageLabel.text = message.text
      return cell
    }else {
      var cell:MessageBubbleTableViewCell
      if message.sentByMe {
        cell = tableView.dequeueReusableCell(withIdentifier: MessageBubbleCellType.rightText.rawValue, for: indexPath) as! RightMessageBubbleTableViewCell
      }else {
        cell = tableView.dequeueReusableCell(withIdentifier: MessageBubbleCellType.leftText.rawValue, for: indexPath) as! LeftMessagebubbleTableViewCell
      }
      cell.messageLabel.text = message.text
      
      return cell
    }
  }
}
