
import UIKit

class NewContactController: UIViewController {
  
  private let profileImageView = ProfileImageView(borderShape: .squircle)
  
  private let firstNameTextField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.placeholder = "First name"
    return textField
  }()
  private let lastNameTextField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.placeholder = "Last name"
    return textField
  }()
  private var constraints: [NSLayoutConstraint] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    title = "New Contact"
    setupLeftBarButton()
    setupRightBarButton()
    setupViewTapGesture()
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    dismissKeyBoard(view)
  }
  // MARK: - Layouts
  override func viewSafeAreaInsetsDidChange() {
    super.viewSafeAreaInsetsDidChange()
    if !constraints.isEmpty {
      NSLayoutConstraint.deactivate(constraints)
      constraints.removeAll()
    }
    setupViewLayout()
  }
  private func setupLeftBarButton(){
    let barButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(BarButtonDidTap))
    navigationItem.leftBarButtonItem = barButtonItem
  }
  private func setupRightBarButton(){
    let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(BarButtonDidTap))
    navigationItem.rightBarButtonItem = barButtonItem
  }
  
  private func setupViewLayout(){
    // 1
    let safeAreaInsets = view.safeAreaInsets
    let marginSpacing: CGFloat = 16
    let topSpace = safeAreaInsets.top + marginSpacing
    let leadingSpace = safeAreaInsets.left + marginSpacing
    let trailingSpace = safeAreaInsets.right + marginSpacing
    // 2
    var constraints: [NSLayoutConstraint] = []
    // 3
    view.addSubview(profileImageView)
    profileImageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(firstNameTextField)
    firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(lastNameTextField)
    lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
    let profileImageViewVerticalConstraints =
      NSLayoutConstraint.constraints(withVisualFormat:
        "V:|-topSpacing-[profileImageView(profileImageViewHeight)]",
                                     options: [],
                                     metrics:
        ["topSpacing": topSpace, "profileImageViewHeight": 40],
                                     views: ["profileImageView": profileImageView])
    constraints += profileImageViewVerticalConstraints
    
    let textFieldsVerticalConstraints =
      NSLayoutConstraint.constraints(withVisualFormat:
        "V:|-topSpacing-[firstNameTextField(profileImageView)]-textFieldsSpacing-[lastNameTextField(firstNameTextField)]",
                                     options: [.alignAllCenterX],
                                     metrics: [
                                      "topSpacing": topSpace,
                                      "textFieldsSpacing": 8],
                                     views: [
                                      "firstNameTextField": firstNameTextField,
                                      "lastNameTextField": lastNameTextField,
                                      "profileImageView": profileImageView])
    constraints += textFieldsVerticalConstraints
    
    let profileImageViewToFirstNameTextFieldHorizontalConstraints =
      NSLayoutConstraint.constraints(withVisualFormat:
        "H:|-leadingSpace-[profileImageView(profileImageViewWidth)]-[firstNameTextField(>=200@1000)]-trailingSpace-|",
                                     options: [],
                                     metrics: [
                                      "leadingSpace": leadingSpace,
                                      "trailingSpace": trailingSpace,
                                      "profileImageViewWidth": 40],
                                     views: [
                                      "profileImageView": profileImageView,
                                      "firstNameTextField": firstNameTextField])
    constraints += profileImageViewToFirstNameTextFieldHorizontalConstraints
    
    let lastNameTextFieldHorizontalConstraints =
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:[lastNameTextField(firstNameTextField)]",
        options: [],
        metrics: nil,
        views: [
          "firstNameTextField": firstNameTextField,
          "lastNameTextField": lastNameTextField])
    constraints += lastNameTextFieldHorizontalConstraints
    
    NSLayoutConstraint.activate(constraints)
    self.constraints = constraints
  }
  private func setupViewTapGesture(){
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard(_:)))
    view.addGestureRecognizer(tapGesture)
  }
  
  //MRAK: -Action
  @objc private func BarButtonDidTap(_ sender:UIBarButtonItem){
    DispatchQueue.main.async {
      self.dismiss(animated: true, completion: nil)
    }
  }
  @objc private func dismissKeyBoard(_ sender:UIView){
    DispatchQueue.main.async {
      self.view.endEditing(true)
    }
  }
}
