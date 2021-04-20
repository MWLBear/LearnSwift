
import UIKit

final class ContactTableViewCell: UITableViewCell {
  // MARK: - IBOutlets
  let nameLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.font = UIFont.systemFont(ofSize: 17)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  // MARK: - Initializers
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  private func setupUI(){
    accessoryType = .detailButton
    contentView.addSubview(nameLabel)
    NSLayoutConstraint.activate([
      nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 48),
      nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
    ])
  }
}
