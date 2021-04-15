//
//  DetailViewController.swift
//  StoreSearch
//
//  Created by admin on 2021/4/13.
//

import UIKit
import MessageUI

class DetailViewController: UIViewController {
    enum AnimationStyle {
        case slide
        case fade
    }
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    
    var searchResult: SearchResult!{
        didSet {
            if isViewLoaded {
                updateUI()
            }
        }
    }
    var downloadTask: URLSessionDownloadTask?
    var dismissStyle = AnimationStyle.fade
    var ispop_up = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if traitCollection.userInterfaceStyle == .light {
            view.tintColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 1)

        }else {
            view.tintColor = UIColor(red: 140/255, green: 140/255, blue: 240/255, alpha: 1)
        }
        popupView.layer.cornerRadius = 10
       
        if ispop_up {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(close))
            gestureRecognizer.cancelsTouchesInView = false
            gestureRecognizer.delegate = self
            view.addGestureRecognizer(gestureRecognizer)
            view.backgroundColor = .clear
        }else {
            view.backgroundColor = UIColor(patternImage:UIImage(named: "LandscapeBackground")!)
            popupView.isHidden = true
            if let displayName = Bundle.main.localizedInfoDictionary?["CFBundleDisplayName"] as? String{
                title = displayName
            }
        }
  
        if searchResult != nil {
            updateUI()
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismissStyle = .slide
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: -Helper Methods
    func updateUI() {
        nameLabel.text = searchResult.name
        if searchResult.artisit.isEmpty {
            artistNameLabel.text = NSLocalizedString("Unknown", comment: "Artist name: Unknown")
        }else {
            artistNameLabel.text = searchResult.artisit
        }
        kindLabel.text = searchResult.type
        genreLabel.text = searchResult.genre
        //Show price
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = searchResult.currency
        let priceText: String
        if searchResult.price == 0 {
            priceText = NSLocalizedString("Free", comment: "Price text: Free")
        }else if let text = formatter.string(from: searchResult.price as NSNumber){
            priceText = text
        }else {
            priceText = ""
        }
        priceButton.setTitle(priceText, for: .normal)
        //Get Image
        if let largeURL = URL(string: searchResult.imageLarge) {
            downloadTask = artworkImageView.loadImage(url: largeURL)
        }
        
        popupView.isHidden = false
    }
    
    @IBAction func openInSource(){
        if let url = URL(string: searchResult.storeURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMenu" {
            let controller = segue.destination as! MenuViewController
            controller.delegate = self
        }
    }
    deinit {
        print("deinit \(self)")
        downloadTask?.cancel()
    }
}

extension DetailViewController: UIViewControllerTransitioningDelegate{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BounceAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch dismissStyle {
        case .slide:
            return SlideOutAnimationController()
        default:
            return FadeOutAnimationController()
        }
    }
}

extension DetailViewController: MenuViewControllerDelegate {
    func menuViewControllerSendEmail(_ controller: MenuViewController) {
        dismiss(animated: true) {
            if MFMailComposeViewController.canSendMail() {
                let controller = MFMailComposeViewController()
                controller.mailComposeDelegate = self
                controller.modalPresentationStyle = .formSheet
                controller.setSubject(NSLocalizedString("Support Request",
                                                        comment: "Email subject"))
                controller.setToRecipients(["your@email-address-here.com"])
                self.present(controller, animated: true, completion: nil)
                
            }
        }
    }
}

extension DetailViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}
