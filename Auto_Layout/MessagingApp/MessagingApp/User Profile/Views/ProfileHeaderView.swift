
import UIKit

final class ProfileHeaderView: UIView {
  private let profileImageView = ProfileImageView(borderShape: .squircle)
  private let leftSpacerView = UIView()
  private let rightSpaceView = UIView()
  
  private let fullNameLable = ProfileNameLabel()
  
  private let messageButton = UIButton.createSystemButton(withTitle: "Message")
  private let callButton = UIButton.createSystemButton(withTitle: "Call")
  private let emailButton = UIButton.createSystemButton(withTitle: "Email")

  private lazy var profileImageStackView = UIStackView(arrangedSubviews: [leftSpacerView,profileImageView,rightSpaceView])
  private lazy var profileStackView:UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [profileImageStackView, fullNameLable])
    stackView.distribution = .fill
    stackView.axis = .vertical
    stackView.spacing = 16
    return stackView
  }()
  
  private lazy var actionStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [messageButton,callButton,emailButton])
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private lazy var stackView:UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [profileStackView,actionStackView])
    stackView.axis = .vertical
    stackView.spacing = 16
    return stackView
  }()
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .groupTableViewBackground
    setupStackView()
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  private func setupStackView(){
    addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(
      [stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
       stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor,constant: 20),
       stackView.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor, constant: 500),
       stackView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8),
       stackView.topAnchor.constraint(equalTo: topAnchor,constant: 26),
       
       profileImageView.widthAnchor.constraint(equalToConstant: 120),
       profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
       
       leftSpacerView.widthAnchor.constraint(equalTo: rightSpaceView.widthAnchor)
      ])
    
    profileImageView.setContentHuggingPriority(UILayoutPriority(251), for: NSLayoutConstraint.Axis.horizontal)
    profileImageView.setContentHuggingPriority(UILayoutPriority(251), for: NSLayoutConstraint.Axis.vertical)
    fullNameLable.setContentHuggingPriority(UILayoutPriority(251), for: NSLayoutConstraint.Axis.horizontal)
    fullNameLable.setContentHuggingPriority(UILayoutPriority(251), for: NSLayoutConstraint.Axis.vertical)
    fullNameLable.setContentCompressionResistancePriority( UILayoutPriority(751),for: NSLayoutConstraint.Axis.vertical)
    messageButton.setContentCompressionResistancePriority( UILayoutPriority(751),for: NSLayoutConstraint.Axis.horizontal)
  }
  
}

private extension UIButton {
  static func createSystemButton(withTitle title: String) ->UIButton {
    let button = UIButton(type: .system)
    button.setTitle(title, for: .normal)
    return button
  }
}
