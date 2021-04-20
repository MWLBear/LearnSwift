

import UIKit

final class ProfileViewController: UIViewController {
  private let profileHeadView = ProfileHeaderView()
  // MARK: - Life Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupProfileHeaderView()
  }
  private func setupProfileHeaderView(){
    view.addSubview(profileHeadView)
    profileHeadView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      profileHeadView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      profileHeadView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      profileHeadView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      profileHeadView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)])
  }
  
}
