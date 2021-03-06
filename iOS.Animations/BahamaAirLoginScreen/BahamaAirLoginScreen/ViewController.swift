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
    let color = CASpringAnimation(keyPath: "backgroundColor")
    color.damping = 5.0
    color.initialVelocity = -10.0
    color.fromValue = layer.backgroundColor
    color.toValue = toColor.cgColor
    color.duration = color.settlingDuration
    layer.add(color, forKey: nil)
    layer.backgroundColor = toColor.cgColor
}
func roundCorners(layer: CALayer, toRadius: CGFloat){
    let round = CASpringAnimation(keyPath: "cornerRadius")
    round.damping = 5.0
    round.toValue = toRadius
    round.duration = round.settlingDuration
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
    let info = UILabel()
    
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
        
        let wobble = CAKeyframeAnimation(keyPath: "transform.rotation")
        wobble.duration = 0.25
        wobble.repeatCount = 4
        wobble.values =  [0.0, -.pi/4.0, 0.0, .pi/4.0, 0.0]
        wobble.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
        heading.layer.add(wobble, forKey: nil)
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
    
    func animateCloud(layer: CALayer) {
        let cloundSpeed = 60 / view.frame.size.width
        let duration = (view.frame.width-layer.frame.origin.x) * cloundSpeed
        
        let cloundMove = CABasicAnimation(keyPath: "position.x")
        cloundMove.duration = Double(duration)
        cloundMove.toValue = self.view.bounds.width + layer.bounds.width / 2
        cloundMove.delegate = self
        cloundMove.setValue("cloud", forKey: "name")
        cloundMove.setValue(layer, forKey: "layer")
        layer.add(cloundMove, forKey: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        view.endEditing(true)
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
        
        info.frame = CGRect(x: 0, y: loginButton.center.y + 60.0, width: view.frame.size.width, height: 30)
        info.backgroundColor = .clear
        info.font = UIFont(name: "HelveticaNeue", size: 12.0)
        info.textAlignment = .center
        info.textColor = .white
        info.text = "Tap on a field and enter username and password"
        view.insertSubview(info, belowSubview: loginButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let formGroup = CAAnimationGroup()
        formGroup.duration = 0.5
        formGroup.fillMode = .forwards
        
        let flyRight = CABasicAnimation(keyPath: "position.x")
        flyRight.fromValue = -view.bounds.size.width/2
        flyRight.toValue = view.bounds.size.width/2
       
        let fadeFieldIn = CABasicAnimation(keyPath: "opacity")
        fadeFieldIn.fromValue = 0.25
        fadeFieldIn.toValue = 1.0
        
        formGroup.animations = [flyRight,fadeFieldIn]
        heading.layer.add(formGroup, forKey: nil)

        formGroup.delegate = self
        formGroup.setValue("form", forKey: "name")
        formGroup.setValue(username.layer, forKey: "layer")

        formGroup.beginTime = CACurrentMediaTime() + 0.3
        username.layer.add(formGroup, forKey: nil)
        
        formGroup.setValue(password.layer, forKey: "layer")
        formGroup.beginTime = CACurrentMediaTime() + 0.4
        password.layer.add(formGroup, forKey: nil)
        
//        username.layer.position.x = view.bounds.size.width/2
//        password.layer.position.x = view.bounds.size.width/2
        
      
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

        
//        animateCloud(cloud: cloud1)
//        animateCloud(cloud: cloud2)
//        animateCloud(cloud: cloud3)
//        animateCloud(cloud: cloud4)
//
        animateCloud(layer: cloud1.layer)
        animateCloud(layer: cloud2.layer)
        animateCloud(layer: cloud3.layer)
        animateCloud(layer: cloud4.layer)

        let flyLeft = CABasicAnimation(keyPath: "position.x")
        flyLeft.fromValue = info.layer.position.x + view.frame.size.width
        flyLeft.toValue = info.layer.position.x
        flyLeft.duration = 5.0
        info.layer.add(flyLeft, forKey: "infoappear")
        
        let faderLabel = CABasicAnimation(keyPath: "opacity")
        faderLabel.fromValue = 0.2
        faderLabel.toValue = 1.0
        faderLabel.duration = 4.5
        info.layer.add(faderLabel, forKey: "fadein")
        
        username.delegate = self
        password.delegate = self
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.beginTime = CACurrentMediaTime() + 0.5
        groupAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        groupAnimation.duration = 0.5
        groupAnimation.fillMode = .backwards
        
        let scaleDowm = CABasicAnimation(keyPath: "transfrom.scale")
        scaleDowm.fromValue = 3.5
        scaleDowm.toValue = 1.0
        
        let rotate = CABasicAnimation(keyPath:"transform.rotation")
        rotate.fromValue = 0.0
        rotate.toValue = 1.0
        
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 0.0
        fade.toValue = 1.0
        
        groupAnimation.animations = [scaleDowm, rotate, fade]
        loginButton.layer.add(groupAnimation, forKey: nil)
        
        
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
        
        let ballon = CALayer()
        ballon.contents = UIImage(named: "balloon")!.cgImage
        ballon.frame = CGRect(x: -50, y: 0, width: 50, height: 60)
        view.layer.insertSublayer(ballon, below: username.layer)
        
        let flight = CAKeyframeAnimation(keyPath: "position")
        flight.duration = 2.0
        flight.values = [
            CGPoint(x: -50, y: 0),
            CGPoint(x: view.frame.width + 50, y: 160),
            CGPoint(x: -50, y: loginButton.center.y)
        ].map{NSValue(cgPoint: $0 )}
        flight.keyTimes = [0.0, 0.5, 1.0]
        ballon.add(flight, forKey: nil)
        ballon.position = CGPoint(x: -50, y: loginButton.center.y)
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
        guard let name = anim.value(forKey: "name") as? String else {
            return
        }
        if name == "form" {
            print("form")
            let layer = anim.value(forKey: "layer") as? CALayer
            anim.setValue(nil, forKey: "layer") //将layer的值设置为nil即可删除对原始图层的引用。
            
            let pulse = CASpringAnimation(keyPath: "transform.scale")
            pulse.damping = 7.5
            pulse.fromValue = 1.25
            pulse.toValue = 1.0
            //settlingDuration估计系统稳定所需的时间；
            pulse.duration = pulse.settlingDuration
            layer?.add(pulse, forKey: nil)
        }
        
        if name == "cloud" {
            if  let layer = anim.value(forKey: "layer") as? CALayer {
                anim.setValue(nil, forKey: "layer")
                layer.position.x = -layer.bounds.width/2
                delay(0.5) {
                    self.animateCloud(layer: layer)
                }
            }
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let runningAnimations = info.layer.animationKeys() else {
            return
        }
        print(runningAnimations)
        info.layer.removeAnimation(forKey: "infoappear")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        if text.count < 5 {
            let jump = CASpringAnimation(keyPath: "position.y")
            jump.initialVelocity = 100.0
            jump.mass = 10.0
            jump.stiffness = 1500.0
            jump.damping = 50.0
            jump.fromValue = textField.layer.position.y + 1.0
            jump.toValue = textField.layer.position.y
            jump.duration = jump.settlingDuration
            textField.layer.add(jump, forKey: nil)
            
            textField.layer.borderWidth = 3.0
            textField.layer.borderColor = UIColor.clear.cgColor
            
            let flash = CASpringAnimation(keyPath: "borderColor")
            flash.damping = 7.0
            flash.stiffness = 200.0
            flash.fromValue = UIColor(red: 1.0, green: 0.27, blue: 0.0, alpha: 1.0).cgColor
            flash.toValue = UIColor.white.cgColor
            flash.duration = flash.settlingDuration
            textField.layer.add(flash, forKey: nil)
        }
    }
}
