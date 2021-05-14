
import UIKit

// A delay function
func delay(seconds: Double, completion: @escaping ()-> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

class ViewController: UIViewController {
    
    @IBOutlet var myAvatar: AvatarView!
    @IBOutlet var opponentAvatar: AvatarView!
    
    @IBOutlet var status: UILabel!
    @IBOutlet var vs: UILabel!
    @IBOutlet var searchAgain: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchForOpponent()
    }
    
    @IBAction func actionSearchAgain() {
        UIApplication.shared.keyWindow!.rootViewController = storyboard!.instantiateViewController(withIdentifier: "ViewController") as UIViewController
    }
    
    func searchForOpponent(){
        let avatarSize = myAvatar.frame.size
        let boundXOffset : CGFloat = avatarSize.width/1.9
        let morphSize = CGSize(width: avatarSize.width*0.85, height: avatarSize.height*1.1)
       
        let rightBouncePoint = CGPoint(x: view.frame.size.width / 2 + boundXOffset, y: myAvatar.center.y)
        let leftBouncePoint = CGPoint(x: view.frame.size.width / 2 - boundXOffset, y: opponentAvatar.center.y)
        
        myAvatar.bounceOff(point: rightBouncePoint, morphSize: morphSize)
        opponentAvatar.bounceOff(point: leftBouncePoint, morphSize: morphSize)
        
        delay(seconds: 4.0, completion: foundOpponent)
    }
 
    func foundOpponent() {
        status.text = "Connecting..."
        opponentAvatar.image = UIImage(named: "avatar-2")
        opponentAvatar.name = "Ray"
        delay(seconds: 4.0, completion: connectedtoOpponet)
    }
    func connectedtoOpponet() {
        myAvatar.shouldTransitionToFinishedState = true
        opponentAvatar.shouldTransitionToFinishedState = true
        delay(seconds: 1.0, completion: completed)
    }
    func completed() {
        status.text = "Ready to play"
        UIView.animate(withDuration: 0.2) {
            self.vs.alpha = 1.0
            self.searchAgain.alpha = 1.0
        }
    }
}

