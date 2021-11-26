//
//  GameViewController.swift
//  background
//
//  Created by admin on 2021/10/19.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let size = CGSize.init(width: 1214, height: 683)
            let scene = GameScene(size: self.view.frame.size)
            let scene2 = SKScene(fileNamed: "TileScene")
            scene.scaleMode = .aspectFill
                
            view.presentScene(scene2)
           
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool{
        return false
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
