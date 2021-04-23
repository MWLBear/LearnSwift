import UIKit
protocol MessageBubbleTableViewCellDelegate {
  func doubleTapForCell(_ cell: MessageBubbleTableViewCell)
}
enum MessageBubbleCellType: String{
  case rightText
  case leftText
}

class MessageBubbleTableViewCell: UITableViewCell {
  var delegate: MessageBubbleTableViewCellDelegate?
  
  lazy var messageLabel: UILabel = {
    let messageLabel = UILabel(frame: .zero)
    messageLabel.textColor = .white
    messageLabel.font = UIFont.systemFont(ofSize: 13)
    messageLabel.numberOfLines = 0
    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    return messageLabel
  }()
  
  lazy var bubbleImageView: UIImageView = {
    let bubbleImageView = UIImageView(frame: .zero)
    bubbleImageView.translatesAutoresizingMaskIntoConstraints = false
    bubbleImageView.contentMode = .scaleToFill
    return bubbleImageView
  }()
  

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
   
    let gesture = UITapGestureRecognizer(target: self,action: #selector(doubleTapped))
    gesture.numberOfTapsRequired = 2
    gesture.cancelsTouchesInView = true
    contentView.addGestureRecognizer(gesture)
    
    configureLauout()
  }
  
  func configureLauout() {
    contentView.addSubview(bubbleImageView)
    contentView.addSubview(messageLabel)
  
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func doubleTapped(){
    delegate?.doubleTapForCell(self)
  }
}
