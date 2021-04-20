

import UIKit

class ProfileNameLabel: UILabel {
  // MARK: - Properties
  override var text: String?{
    didSet {
      guard let words = text?.components(separatedBy: .whitespaces) else { return }
      let joinedWords = words.joined(separator: "\n")
      guard text != joinedWords else { return }
      DispatchQueue.main.async {
        self.text = joinedWords
      }
    }
  }
  // MARK: - Views Setup
 
  init(fullName:String? = "Full Name") {
    super.init(frame: .zero)
    setTextAttributes()
    text = fullName
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  private func setTextAttributes() {
    numberOfLines = 0
    textAlignment = .center
    font = UIFont.systemFont(ofSize: 24)
  }
}
