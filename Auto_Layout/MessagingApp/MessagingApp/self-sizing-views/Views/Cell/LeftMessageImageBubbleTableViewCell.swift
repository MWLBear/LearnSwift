
import UIKit

class LeftMessageImageBubbleTableViewCell: ImageBubbleTableViewCell {
  private let blueBubbleImageName = "blue-bubble"

  override func configureLauout() {
    super.configureLauout()
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: bubbleImageView.topAnchor,constant: -10),
      contentView.trailingAnchor.constraint(greaterThanOrEqualTo:  bubbleImageView.trailingAnchor,constant: 20),
      contentView.bottomAnchor.constraint(equalTo: bubbleImageView.bottomAnchor,constant: 10),
      contentView.leadingAnchor.constraint(equalTo: bubbleImageView.leadingAnchor,constant: -20),
    
      bubbleImageView.topAnchor.constraint(equalTo: messageImageView.topAnchor,constant: -10),
      bubbleImageView.trailingAnchor.constraint(equalTo: messageImageView.trailingAnchor,constant: 10),
      bubbleImageView.leadingAnchor.constraint(equalTo: messageImageView.leadingAnchor,constant: -20),
      
      messageImageView.widthAnchor.constraint(equalToConstant: 150),
      messageImageView.heightAnchor.constraint(equalToConstant: 150),

      messageLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor,constant: 10),
      messageLabel.trailingAnchor.constraint(equalTo: messageImageView.trailingAnchor),
      messageLabel.bottomAnchor.constraint(equalTo: bubbleImageView.bottomAnchor,constant: -5),
      messageLabel.leadingAnchor.constraint(equalTo: messageImageView.leadingAnchor)
    ])
    let insets = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 10)
    let image = UIImage(named: blueBubbleImageName)?.imageFlippedForRightToLeftLayoutDirection()
    bubbleImageView.image = image?.resizableImage(withCapInsets: insets, resizingMode: .stretch)
    
  }
}
