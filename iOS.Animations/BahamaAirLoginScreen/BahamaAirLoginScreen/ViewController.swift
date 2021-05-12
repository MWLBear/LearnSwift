/*
 * Copyright (c) 2014-present Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

// A delay function
func delay(_ seconds: Double, completion: @escaping ()->Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}
func tintBackgroundColor(layer: CALayer, toColor: UIColor) {
    let color = CABasicAnimation(keyPath: "backgroundColor")
    color.fromValue = layer.backgroundColor
    color.toValue = toColor.cgColor
    color.duration = 1.0
    layer.add(color, forKey: nil)
    layer.backgroundColor = toColor.cgColor
}
func roundCorners(layer: CALayer, toRadius: CGFloat){
    let round = CABasicAnimation(keyPath: "cornerRadius")
    round.toValue = toRadius
    round.duration = 0.33
    layer.add(round, forKey: nil)
    layer.cornerRadius = toRadius
}


class ViewController: UIViewController {
    
    // MARK: IB outlets
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var heading: UILabel!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var cloud1: UIImageView!
    @IBOutlet var cloud2: UIImageView!
    @IBOutlet var cloud3: UIImageView!
    @IBOutlet var cloud4: UIImageView!
    
    // MARK: further UI
    
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
    lazy var myView : UIView = {
        let uiview = UIView(frame: CGRect(x: 100, y: 0, width: 50, height: 50))
        uiview.backgroundColor = .red
        return uiview
    }()
    var statusPosition = CGPoint.zero
    
    // MARK: view controller methods
    func showMessage(index: Int) {
        label.text = messages[index]
        UIView.transition(with: status, duration: 0.33, options: [.curveEaseOut,.transitionFlipFromBottom]) {
            self.status.isHidden = false
        } completion: { _ in
            delay(2.0) {
                if index < self.messages.count - 1 {
                    self.removeMessage(index: index)
                }else {
                    self.resetForm()
                }
            }
        }
    }
    
    func removeMessage(index: Int)  {
        UIView.animate(withDuration: 0.33, delay: 0, options: []) {
            self.status.center.x += self.view.frame.size.width
        } completion: { _ in
            self.status.isHidden = true
            self.status.center = self.statusPosition
            self.showMessage(index: index + 1)
        }

    }
    
    func resetForm() {
        UIView.transition(with: self.status, duration: 0.2, options: [.curveEaseOut,.transitionFlipFromTop]) {
            self.status.isHidden = true
            self.status.center = self.statusPosition
        } completion: { _ in
            
        }
        UIView.animate(withDuration: 0.2, delay: 0, options: []) {
            self.spinner.center = CGPoint(x: -20, y: 6)
            self.spinner.alpha = 0
            self.loginButton.center.y -= 60
            self.loginButton.bounds.size.width -= 80.0

        } completion: { _ in
            let tintColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
            tintBackgroundColor(layer: self.loginButton.layer, toColor: tintColor)
            roundCorners(layer: self.loginButton.layer, toRadius: 10.0)

        }
        loginButton.isEnabled = true
    }
    
    func animateCloud(cloud: UIImageView) {
        let cloundSpeed = 60 / view.frame.size.width
        let duration = (view.frame.width-cloud.frame.origin.x) * cloundSpeed
        
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: .curveLinear) {
            cloud.frame.origin.x = self.view.frame.size.width
        } completion: { _ in
            cloud.frame.origin.x = -cloud.frame.size.width
            self.animateCloud(cloud: cloud)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        let move = CABasicAnimation(keyPath: "position.y")
        move.fromValue = 100
        move.toValue = 500
        move.duration = 1.0
        move.beginTime = CACurrentMediaTime() + 2.0
        move.fillMode = .both
        move.delegate = self

        self.myView.layer.position.y = 500
        self.myView.layer.add(move, forKey: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(self.myView)
        
        //set up the UI
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        loginButton.addSubview(spinner)
        status.isHidden = true
        status.center = loginButton.center
        view.addSubview(status)
        
        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .center
        status.addSubview(label)
        
        statusPosition = status.center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let flyRight = CABasicAnimation(keyPath: "position.x")
        flyRight.fromValue = -view.bounds.size.width/2
        flyRight.toValue = view.bounds.size.width/2
        flyRight.duration = 0.5
        heading.layer.add(flyRight, forKey: nil)

        flyRight.beginTime = CACurrentMediaTime() + 0.3
        flyRight.fillMode = .both
        username.layer.add(flyRight, forKey: nil)
        
        flyRight.beginTime = CACurrentMediaTime() + 0.4
        password.layer.add(flyRight, forKey: nil)
        
        username.layer.position.x = view.bounds.size.width/2
        password.layer.position.x = view.bounds.size.width/2
        
        loginButton.center.y += 30
        loginButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let cloudAl = CABasicAnimation(keyPath: "opacity")
        cloudAl.fromValue = 0.0
        cloudAl.toValue = 1.0
        cloudAl.duration = 0.5
        cloudAl.fillMode = .backwards
        cloudAl.beginTime = CACurrentMediaTime() + 0.5
        cloud1.layer.add(cloudAl, forKey: nil)
        
        cloudAl.beginTime = CACurrentMediaTime() + 0.7
        cloud2.layer.add(cloudAl, forKey: nil)

        cloudAl.beginTime = CACurrentMediaTime() + 0.9
        cloud3.layer.add(cloudAl, forKey: nil)

        cloudAl.beginTime = CACurrentMediaTime() + 1.1
        cloud4.layer.add(cloudAl, forKey: nil)

        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.loginButton.center.y -= 30
            self.loginButton.alpha = 1
        }, completion: nil)
        
        animateCloud(cloud: cloud1)
        animateCloud(cloud: cloud2)
        animateCloud(cloud: cloud3)
        animateCloud(cloud: cloud4)
    }
    
    // MARK: further methods
    
    @IBAction func login() {
        view.endEditing(true)
        loginButton.isEnabled = false
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: {
            self.loginButton.bounds.size.width += 80.0
        }) { _ in
            self.showMessage(index: 0)
        }
        
        UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            self.loginButton.center.y += 60
            self.spinner.center = CGPoint(x: 40, y: self.loginButton.frame.size.height / 2)
            self.spinner.alpha = 1
        }, completion: nil)
        
        let tintColor = UIColor(red: 0.85, green: 0.83, blue: 0.45,
        alpha: 1.0)
        tintBackgroundColor(layer: loginButton.layer, toColor:tintColor)
        roundCorners(layer: loginButton.layer, toRadius: 25.0)
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = (textField === username) ? password : username
        nextField?.becomeFirstResponder()
        return true
    }
    
}

extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        delay(3) {
            self.myView.layer.removeAllAnimations()
        }
    }
}
