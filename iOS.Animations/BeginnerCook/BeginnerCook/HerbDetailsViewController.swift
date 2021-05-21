
import UIKit

class HerbDetailsViewController: UIViewController, UIViewControllerTransitioningDelegate {
  
  @IBOutlet var containerView: UIView!
  
  @IBOutlet var bgImage: UIImageView!
  @IBOutlet var titleView: UILabel!
  @IBOutlet var descriptionView: UITextView!
  @IBOutlet var licenseButton: UIButton!
  @IBOutlet var authorButton: UIButton!
  
  var herb: HerbModel!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    bgImage.image = UIImage(named: herb.image)
    titleView.text = herb.name
    descriptionView.text = herb.description
    
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionClose(_:))))
  }
  
  @objc func actionClose(_ tap: UITapGestureRecognizer) {
    presentingViewController?.dismiss(animated: true, completion: nil)
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  //MARK: button actions
  
  @IBAction func actionLicense(_ sender: AnyObject) {
    UIApplication.shared.open(URL(string: herb!.license)!)
  }
  
  @IBAction func actionAuthor(_ sender: AnyObject) {
    UIApplication.shared.open(URL(string: herb!.credit)!)
  }
  
  
}
