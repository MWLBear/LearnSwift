import UIKit
enum MessageBubbleCellType: String{
  case rightText
  case leftText
}

class MessageBubbleTableViewCell: UITableViewCell {
  let greenBubbleImageName = "green-bubble"
  let blueBubbleImageName = "blue-bubble"
  lazy var messageLabel: UILabel = {
    let messageLabel = UILabel()
    messageLabel.textColor = .black
    messageLabel.font = UIFont.systemFont(ofSize: 13)
    messageLabel.numberOfLines = 0
    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    return messageLabel
  }()
  
  lazy var bubbleImageView: UIImageView = {
    let bubbleImageView = UIImageView(frame: .zero)
    bubbleImageView.translatesAutoresizingMaskIntoConstraints = false
    bubbleImageView.contentMode = .scaleAspectFill
    return bubbleImageView
  }()
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureLauout()
  }
  
  func configureLauout() {
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  

}
