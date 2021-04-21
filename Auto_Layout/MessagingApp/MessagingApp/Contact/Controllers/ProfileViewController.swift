/**
 • Constraints between a scroll view and the views outside of its view hierarchy act on the scroll view’s frame.
 • Constraints between a scroll view and views inside of its view hierarchy act on the scroll view’s content area.
 • Be extra careful when setting the size and position of your scroll view. Remember that apart from setting its size and position, you’ll have to specify a content area that will affect the way the scroll view behaves.
 • It’s strongly recommended to add a content view that acts as a container for all of the views inside of the scroll view. This makes it easier to work with a scroll view that can grow in size.
 • While working with stack views (or any views) inside of a scroll view that acts as the content area, the width and height determine if the scroll view will have vertical and horizontal scrolling.
 Remember to use frameLayoutGuide and contentLayoutGuide when creating the constraints for scroll views.
 */

import UIKit

final class ProfileViewController: UIViewController {
  private let profileHeadView = ProfileHeaderView()
  private let mainStackView = UIStackView()
  private let scrollView = UIScrollView()
  private lazy var settingButton:UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Setting", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.layer.borderColor = UIColor.lightGray.cgColor
    button.layer.borderWidth = 1.0
    button.backgroundColor = .blue
    button.layer.cornerRadius = 40
    return button
  }()
  // MARK: - Life Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
   
    setupScrollView()
    setupMainStackView()
    setupSettingButton()
  }
  //MRAK : - Layouts
  private func setupProfileHeaderView(){
    view.addSubview(profileHeadView)
    profileHeadView.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate([
//      profileHeadView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//      profileHeadView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//      profileHeadView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//      profileHeadView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)])
    profileHeadView.heightAnchor.constraint(equalToConstant: 360).isActive = true
    mainStackView.addArrangedSubview(profileHeadView)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  private func setupSettingButton(){
  
    scrollView.addSubview(settingButton)
    
    NSLayoutConstraint.activate([
      settingButton.widthAnchor.constraint(equalToConstant: 80),
      settingButton.heightAnchor.constraint(equalToConstant: 80),
      settingButton.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor,constant: -20),
      settingButton.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor,constant: -20)

    ])
  }
  
  private func setupScrollView(){
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(scrollView)
    //This layout guide refers to the frame of the scroll view, not the content area.
    let frameLayoutGuide = scrollView.frameLayoutGuide
    
    NSLayoutConstraint.activate([
      frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      frameLayoutGuide.trailingAnchor.constraint(equalTo:view.trailingAnchor),
      frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  private func setupMainStackView(){
    mainStackView.axis = .vertical
    mainStackView.distribution = .equalSpacing
    mainStackView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(mainStackView)
    //This layout guide represents the content area of the scrollView.
    let contentLayoutGuide = scrollView.contentLayoutGuide
    //Since the Stack View will grow vertically, it’s not necessary to indicate the bottom constraint.
    NSLayoutConstraint.activate([
      mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
      mainStackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
      mainStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
      mainStackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
      mainStackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor)

    ])
    setupProfileHeaderView()
    setupButtons()
  }
}
// MARK: - Buttons Configuration
extension ProfileViewController {
  private func createButton(text:String,color:UIColor = .blue) -> UIButton {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.heightAnchor.constraint(equalToConstant: 55).isActive = true
    button.setTitle(text, for: .normal)
    button.setTitleColor(color, for: .normal)
    button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0)
    button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    return button
  }
  
  @objc func buttonPressed(_ sender: UIButton){
    let buttonTitle = sender.titleLabel?.text ?? ""
    let message = "\(buttonTitle) button has been pressed"
    let alert = UIAlertController(title: "Button pressed", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  func setupButtons() {
    let buttonTitles = [
      "Share Profile", "Favorites Messages", "Saved Messages",
      "Bookmarks", "History", "Notifications", "Find Friends",
      "Security", "Help", "Logout"]
    
    let buttonStack = UIStackView()
    buttonStack.translatesAutoresizingMaskIntoConstraints = false
    buttonStack.alignment = .fill
    buttonStack.axis = .vertical
    buttonStack.distribution = .equalSpacing
    buttonTitles.forEach { buttonTitle in
      buttonStack.addArrangedSubview(createButton(text: buttonTitle))
    }
    mainStackView.addArrangedSubview(buttonStack)
    NSLayoutConstraint.activate([
      buttonStack.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
      buttonStack.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor)
    ])
  }
}
