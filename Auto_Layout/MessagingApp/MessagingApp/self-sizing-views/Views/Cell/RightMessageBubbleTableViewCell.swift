
import UIKit

class RightMessageBubbleTableViewCell: MessageBubbleTableViewCell {
  let greenBubbleImageName = "green-bubble"

  override func configureLauout() {
    super.configureLauout()
    NSLayoutConstraint.activate([
      //1
      contentView.topAnchor.constraint(equalTo: bubbleImageView.topAnchor, constant: -10),
      contentView.trailingAnchor.constraint(equalTo: bubbleImageView.trailingAnchor, constant: 20),
      contentView.bottomAnchor.constraint(equalTo: bubbleImageView.bottomAnchor, constant: 10),
      contentView.leadingAnchor.constraint(lessThanOrEqualTo: bubbleImageView.leadingAnchor, constant: -20),
      //2
      bubbleImageView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -5),
      bubbleImageView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 20),
      bubbleImageView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 5),
      bubbleImageView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -10)
    ])
    
    //3
    let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
    //4
    let image = UIImage(named: greenBubbleImageName)!
      .imageFlippedForRightToLeftLayoutDirection()
    //5
    bubbleImageView.image = image.resizableImage(withCapInsets: insets, resizingMode: .stretch)
  
  }
}
