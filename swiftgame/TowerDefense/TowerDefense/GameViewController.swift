//
//  GameViewController.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/8/9.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

	lazy var startScene: StartScene = {
		let scene = StartScene.init(size: CGSize.init(width: 1214, height: 683))
		scene.scaleMode = .aspectFit
		scene.startAction = {
			scene.view?.presentScene(self.selectedMapScene, transition: SKTransition.doorsOpenHorizontal(withDuration: 0.6))
		}
		return scene
	}()
	
	lazy var selectedMapScene: SelectedMapScene = {
		let scene = SelectedMapScene.init(size: CGSize.init(width: 1214, height: 683))
		scene.scaleMode = .aspectFit
		scene.backAction = {
			scene.view?.presentScene(self.startScene, transition: SKTransition.doorsCloseHorizontal(withDuration: 0.6))
		}
		scene.startGame = { (mapConfig) in
			self.gameScene.mapConfig = mapConfig
			scene.view?.presentScene(self.gameScene, transition: SKTransition.fade(withDuration: 0.3))
			self.gameScene.initMap()
		}
		return scene
	}()
	
	lazy var gameScene: GameScene = {
		let scene = GameScene.init(size: CGSize.init(width: 1214, height: 683))
		scene.scaleMode = .aspectFit
		
		scene.quitAction = {
			scene.view?.presentScene(self.startScene, transition: SKTransition.fade(withDuration: 0.3))
		}
	
		return scene
	}()
	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        if let view = self.view as! SKView? {
			
			view.presentScene(startScene)
            view.ignoresSiblingOrder = true
            view.showsPhysics = true
            view.showsFPS = true
            view.showsNodeCount = true
			view.showsDrawCount = true
        }
		self.view.backgroundColor = UIColor.red
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
