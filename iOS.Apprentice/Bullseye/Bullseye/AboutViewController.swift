//
//  AboutViewController.swift
//  Bullseye
//
//  Created by admin on 2021/3/26.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var about: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      guard  let url = Bundle.main.url(forResource: "BullsEye.html", withExtension: nil)
      else { return }
        self.about.load(URLRequest(url: url))
    }

    @IBAction func Close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
