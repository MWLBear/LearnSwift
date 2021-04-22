
import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
  //MARK: Properties
  private let label: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 26)
    label.textAlignment = .center
    label.numberOfLines = 0
    label.setContentHuggingPriority(.required, for: .horizontal)
    return label
  }()
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private let topSpacerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let bottomSpacerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [topSpacerView,imageView, label, bottomSpacerView])
    stackView.axis = .vertical
    return stackView
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
    backgroundColor = .white
    setupStackView()
  }
  private func setupStackView(){
    addSubview(stackView)
    stackView.fillSuperView()
    NSLayoutConstraint.activate([
      topSpacerView.heightAnchor.constraint(equalTo: bottomSpacerView.heightAnchor)
    ])
  }
  
  //MRAK: - User Interface
  func configureCell(username:UserStory.Username) {
    label.text = "\(username.rawValue.capitalized)\nStories"
    imageView.image = UIImage(named: username.rawValue)
  }
}
