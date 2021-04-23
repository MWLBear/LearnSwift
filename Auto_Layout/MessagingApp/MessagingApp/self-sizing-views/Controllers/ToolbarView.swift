

import UIKit
protocol ToolbarViewDelegate {
  func toolbarView(_ toolbarView: ToolbarView, didFavoritedWith tag: Int)
  func toolbarView(_ toolbarView: ToolbarView, didLikedWith tag: Int)
}

class ToolbarView: UIView {
  var delegate: ToolbarViewDelegate?
  private lazy var likeButton: UIButton = {
    let likeButton = UIButton(type: .custom)
    let likeButtonImage = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
    likeButton.setImage(likeButtonImage, for: .normal)
    likeButton.tintColor = .red
    likeButton.addTarget(self, action: #selector(didLiked), for: .touchUpInside)
    
    return likeButton
  }()
  private lazy var favoriteButton: UIButton = {
    let favoriteButton = UIButton()
    let favoriteButtonImage = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
    favoriteButton.setImage(favoriteButtonImage, for: .normal)
    favoriteButton.tintColor = .orange
    favoriteButton.addTarget(self, action: #selector(didFavorited), for: .touchUpInside)
    return favoriteButton
  }()
  private lazy var stackview: UIStackView = {
    let stackview = UIStackView()
    stackview.translatesAutoresizingMaskIntoConstraints = false
    stackview.distribution = .fillEqually
    stackview.axis = .horizontal
    stackview.spacing = 5
    
    stackview.addArrangedSubview(favoriteButton)
    stackview.addArrangedSubview(likeButton)
    return stackview
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpView()
    layoutSubView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  private func setUpView(){
    self.alpha = 0.98
    self.backgroundColor = .white
    self.layer.cornerRadius = 10
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.layer.borderWidth = 0.5
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  private func layoutSubView(){
    addSubview(stackview)

    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: 70),
      heightAnchor.constraint(equalToConstant: 30),
      
      stackview.centerXAnchor.constraint(equalTo: centerXAnchor),
      stackview.centerYAnchor.constraint(equalTo: centerYAnchor),
      stackview.widthAnchor.constraint(equalToConstant: 65),
      stackview.heightAnchor.constraint(equalToConstant: 25),
    ])

  }
  
  func update(isLiked: Bool, isFavorited: Bool) {
    let likeButtonColor: UIColor = isLiked ? .red : .lightGray
    likeButton.tintColor = likeButtonColor
    
    let favoriteButtonColor: UIColor = isFavorited ? .orange : .lightGray
    favoriteButton.tintColor = favoriteButtonColor
  }
  
  func toogleLikeButton() {
    let color: UIColor = likeButton.tintColor == .red ? .lightGray : .red
    likeButton.tintColor = color
  }
  
  func toogleFavoriteButton() {
    let color: UIColor = favoriteButton.tintColor == .orange ? .lightGray : .orange
    favoriteButton.tintColor = color
  }
  
  @objc func didFavorited() {
    toogleFavoriteButton()
    delegate?.toolbarView(self, didFavoritedWith: tag)
  }
  
  @objc func didLiked() {
    toogleLikeButton()
    delegate?.toolbarView(self, didLikedWith: tag)
  }
  
  
}
