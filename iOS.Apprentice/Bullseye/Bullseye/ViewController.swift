//
//  ViewController.swift
//  Bullseye
//
//  Created by admin on 2021/1/8.
//

import UIKit

class ViewController: UIViewController {

    var currentValue:Int = 0
    var targetValue = 0
    var score = 0
    var count = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        startNewGame()
    }
    
    func setUI() {
        
        let thumImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumImageNormal, for: .normal)
        
        let thumImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right:
                                    14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    @IBAction func showAlert(){
        
        let different = abs(targetValue - currentValue)
        var points = 100 - different
        
        var title = ""
        if different == 0 {
            title = "Prefect!"
            points += 200
        }else if different < 5 {
            title = "You almost hat it"
            points += 50
        }else if different < 10 {
            title = "Pretty good!"
        }else {
            title = "Not even close..."
        }
        
        
        score += points
        let message = "Your scored is \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            self.startNewRound()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func sliderMoved(_ sender: UISlider) {
        currentValue = lrintf(slider.value)
    }
    
    
    @IBAction func infoClick(_ sender: UIButton) {
        
    }
    
    @IBAction func startNewGame() {
        
        score = 0
        count = 0
        startNewRound()
        let transiton = CATransition()
        transiton.type = CATransitionType.fade
        transiton.duration = 1
        transiton.timingFunction = CAMediaTimingFunction(name: .easeOut)
        view.layer.add(transiton, forKey: nil)
        
    }
    
    func startNewRound() {
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        count += 1
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(count)
    }
}

