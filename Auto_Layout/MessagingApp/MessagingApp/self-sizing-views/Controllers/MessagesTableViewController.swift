
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
    tableView.separatorStyle = .none
    tableView.rowHeight = UITableView.automaticDimension
  }
  
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return messages.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let message = messages[indexPath.row]
    
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
