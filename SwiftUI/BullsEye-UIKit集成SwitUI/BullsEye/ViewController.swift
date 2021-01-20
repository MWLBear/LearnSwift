
import UIKit
import SwiftUI

class ViewController: UIViewController {
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  
  var currentValue = 50
  var targetValue = Int.random(in: 1...100)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    targetLabel.text = String(targetValue)
  }
  
  @IBSegueAction func openRGBullsEye(_ coder: NSCoder) -> UIViewController? {
     UIHostingController(coder: coder, rootView: ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5))
  }
  @IBAction func showAlert() {
    let difference = abs(targetValue - currentValue)
    let points = 100 - difference
    
    let alert = UIAlertController(title: "Your Score",
      message: String(points), preferredStyle: .alert)
    
    let action = UIAlertAction(title: "OK",
      style: .default, handler: nil)
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func sliderMoved(_ slider: UISlider) {
    currentValue = lroundf(slider.value)
  }
  
}

