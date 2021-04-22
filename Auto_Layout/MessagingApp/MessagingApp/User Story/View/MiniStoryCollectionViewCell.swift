import UIKit

class MiniStoryCollectionViewCell: UICollectionViewCell {
  private let profileImageView = ProfileImageView(borderShape: .circle)
  
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
    contentView.addSubview(profileImageView)
    profileImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      profileImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
  func configureCell(imageName:String) {
    profileImageView.image = UIImage(named: imageName)
  }
}
