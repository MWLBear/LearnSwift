

import UIKit
class ContactPreviewView: UIView {
  
  @IBOutlet var photoImageView: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var callButton: UIButton!
  let nibName = "ContactPreviewView"

  override init(frame: CGRect) {
    super.init(frame: frame)
    loadView()
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    loadView()
  }
  
  func loadView() {
    let bundle = Bundle(for: ContactPreviewView.self)
    let nib = UINib(nibName: nibName, bundle: bundle)
    let view = nib.instantiate(withOwner: self).first as! UIView
    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    setupLayoutInView(view)
    addSubview(view)
  }
  
  private func setupLayoutInView(_ view: UIView) {
    //1
    let layoutGuide = UILayoutGuide()
    
    //2
    view.addLayoutGuide(layoutGuide)

    //3
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    callButton.translatesAutoresizingMaskIntoConstraints = false
    
    //4
    NSLayoutConstraint.activate([
        nameLabel.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
        nameLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
        nameLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
        callButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
        callButton.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor)
      ])
    
    //5
    let margins = view.layoutMarginsGuide
    
    //6
    NSLayoutConstraint.activate([
        layoutGuide.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 5),
        layoutGuide.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
        layoutGuide.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
        layoutGuide.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
      ])
  }
}
