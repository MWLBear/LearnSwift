

import UIKit
enum ImageBubbleCellType: String{
  case rightImageText
  case leftImageText
}


class ImageBubbleTableViewCell: MessageBubbleTableViewCell {

  lazy var messageImageView:UIImageView =  {
    let messageImageView = UIImageView(frame: .zero)
    messageImageView.translatesAutoresizingMaskIntoConstraints = false
    messageImageView.contentMode = .scaleAspectFill
    messageImageView.clipsToBounds = true
    messageImageView.layer.cornerRadius = 5
    messageImageView.layer.borderWidth = 1.0
    messageImageView.layer.borderColor = UIColor.lightGray.cgColor
    messageImageView.backgroundColor = .white
    return messageImageView
  }()
  
  override func configureLauout() {
    super.configureLauout()
    contentView.addSubview(messageImageView)
  }

}
