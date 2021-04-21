
import UIKit

class RightMessageImageTableViewCell: ImageBubbleTableViewCell {
  private let greenBubbleImageName = "green-bubble"

  override func configureLauout() {
    super.configureLauout()
    
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: bubbleImageView.topAnchor,constant: -10),
      contentView.trailingAnchor.constraint(equalTo:  bubbleImageView.trailingAnchor,constant: 20),
      contentView.bottomAnchor.constraint(equalTo: bubbleImageView.bottomAnchor,constant: 10),
      contentView.leadingAnchor.constraint(lessThanOrEqualTo: bubbleImageView.leadingAnchor,constant: -20),
    
      bubbleImageView.topAnchor.constraint(equalTo: messageImageView.topAnchor,constant: -10),
      bubbleImageView.trailingAnchor.constraint(equalTo: messageImageView.trailingAnchor,constant: 20),
      bubbleImageView.leadingAnchor.constraint(equalTo: messageImageView.leadingAnchor,constant: -10),
      
      messageImageView.widthAnchor.constraint(equalToConstant: 150),
      messageImageView.heightAnchor.constraint(equalToConstant: 150),

      messageLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor,constant: 10),
      messageLabel.trailingAnchor.constraint(equalTo: messageImageView.trailingAnchor),
      messageLabel.bottomAnchor.constraint(equalTo: bubbleImageView.bottomAnchor,constant: -5),
      messageLabel.leadingAnchor.constraint(equalTo: messageImageView.leadingAnchor)
    ])
    let insets = UIEdgeInsets(top: 10, left: 10, bottom: 30, right: 10)
    let image = UIImage(named: greenBubbleImageName)!.imageFlippedForRightToLeftLayoutDirection()
    bubbleImageView.image = image.resizableImage(withCapInsets: insets, resizingMode: .stretch)
  }

}
