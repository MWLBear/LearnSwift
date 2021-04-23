
import UIKit

class MessagesTableViewController: UITableViewController {
  
  private var messages = Message.fetchAll()
  private let toobarView = ToolbarView()
  private var toolbarViewTopConstraint: NSLayoutConstraint!
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    setupToolbarView()
    
    let gesture = UITapGestureRecognizer(target: self, action: #selector(hideToolbarView))
    gesture.numberOfTapsRequired = 1;
    gesture.delegate = self
    view.addGestureRecognizer(gesture)
  
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
  
  func setupToolbarView() {
    view.addSubview(toobarView)
    toobarView.delegate = self
    toobarView.translatesAutoresizingMaskIntoConstraints = false
    toolbarViewTopConstraint = toobarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: -100)
    toolbarViewTopConstraint.isActive = true
    toobarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 30).isActive = true
  }
  
  @objc func hideToolbarView(){
    print("hideToolbarView")
    self.toolbarViewTopConstraint.constant = -100
    //2
    UIView.animate(
      withDuration: 1.0,delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [],
      animations: {
        self.toobarView.alpha = 0
        self.view.layoutIfNeeded()
      },
      completion: nil)
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
      cell.delegate = self
      return cell
    }else {
      var cell:MessageBubbleTableViewCell
      if message.sentByMe {
        cell = tableView.dequeueReusableCell(withIdentifier: MessageBubbleCellType.rightText.rawValue, for: indexPath) as! RightMessageBubbleTableViewCell
      }else {
        cell = tableView.dequeueReusableCell(withIdentifier: MessageBubbleCellType.leftText.rawValue, for: indexPath) as! LeftMessagebubbleTableViewCell
      }
      cell.messageLabel.text = message.text
      cell.delegate = self
      return cell
    }
  }
}

extension MessagesTableViewController: MessageBubbleTableViewCellDelegate {
  func doubleTapForCell(_ cell: MessageBubbleTableViewCell) {
    print(cell)
    guard let indexPath = self.tableView.indexPath(for: cell) else { return }
    let message = messages[indexPath.row]
    guard message.sentByMe == false else { return }
    
    if cell.isKind(of: ImageBubbleTableViewCell.self) {
      toolbarViewTopConstraint.constant = cell.frame.maxY - cell.frame.size.height / 3
    }else {
      toolbarViewTopConstraint.constant = cell.frame.midY

    }
    toobarView.alpha = 0.95
    
    toobarView.update(isLiked: message.isLiked, isFavorited: message.isisFavorited)
    toobarView.tag = indexPath.row
    
    UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [], animations: {
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
}

extension MessagesTableViewController: ToolbarViewDelegate {
  func toolbarView(_ toolbarView: ToolbarView, didFavoritedWith tag: Int) {
    messages[tag].isisFavorited.toggle()
  }
  
  func toolbarView(_ toolbarView: ToolbarView, didLikedWith tag: Int) {
    messages[tag].isLiked.toggle()
  }
}

extension MessagesTableViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer( _ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch ) -> Bool {
    return touch.view == tableView
  }
}
