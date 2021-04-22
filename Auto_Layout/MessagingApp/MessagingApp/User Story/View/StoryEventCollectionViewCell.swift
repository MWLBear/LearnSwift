
import UIKit

class StoryEventCollectionViewCell: UICollectionViewCell {
  private let imageView:UIImageView = {
    let imageView = UIImageView(frame: .zero)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  private func commonInit(){
    setupProfileImageView()
  }
  private func setupProfileImageView(){
    contentView.addSubview(imageView)
    NSLayoutConstraint.activate([
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
  func configureCell(storyEvent:StoryEvent) {
    imageView.image =  storyEvent.image
  }
}
