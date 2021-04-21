import UIKit

class LeftMessagebubbleTableViewCell: MessageBubbleTableViewCell {
  private let blueBubbleImageName = "blue-bubble"

  override func configureLauout() {
    super.configureLauout()
    
    NSLayoutConstraint.activate([ //1
      contentView.topAnchor.constraint( equalTo: bubbleImageView.topAnchor, constant: -10),
      contentView.trailingAnchor.constraint( greaterThanOrEqualTo: bubbleImageView.trailingAnchor, constant: 20),
      contentView.bottomAnchor.constraint( equalTo: bubbleImageView.bottomAnchor, constant: 10),
      contentView.leadingAnchor.constraint( equalTo: bubbleImageView.leadingAnchor, constant: -20),
      //2
      bubbleImageView.topAnchor.constraint( equalTo: messageLabel.topAnchor, constant: -5),
      bubbleImageView.trailingAnchor.constraint( equalTo: messageLabel.trailingAnchor, constant: 10),
      bubbleImageView.bottomAnchor.constraint( equalTo: messageLabel.bottomAnchor, constant: 5),
      bubbleImageView.leadingAnchor.constraint( equalTo: messageLabel.leadingAnchor, constant: -20),
      
    ])
    let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
    let image = UIImage(named: blueBubbleImageName)!.imageFlippedForRightToLeftLayoutDirection()
    bubbleImageView.image = image.resizableImage( withCapInsets: insets,resizingMode: .stretch)
  }
}
