//
//  GameViewController.swift
//  Birds
//
//  Created by Roman Yakovliev on 16.10.2021.
//

import UIKit
import SpriteKit
import GameplayKit

protocol SceneManagerDelegate {
    func presentMenuScene()
    func presentLevelScene()
    func presentGameSceneFor(level: Int)
}

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        presentMenuScene()
    }
}

extension GameViewController: SceneManagerDelegate {
    
    func presentMenuScene() {
        let menuScene = MenuScene()
        menuScene.SceneManagerDelegate = self
        present(scene: menuScene)
    }
    
    func presentLevelScene() {
        let levelScene = LevelScene()
        levelScene.SceneManagerDelegate = self
        present(scene: levelScene)
    }
    
    func presentGameSceneFor(level: Int) {
        let sceneName = "GameScene_\(level)"
        if let gameScene = SKScene(fileNamed: sceneName) as? GameScene {
            gameScene.SceneManagerDelegate = self
            present(scene: gameScene)
        }
    }
    
    func present(scene: SKScene) {
        // Load the SKScene
        if let view = self.view as! SKView? {
            // Set the scale mode to .resizeFill to make scene automatically resize so that its dimensions always match those of the view.
            scene.scaleMode = .resizeFill
            // Present the scene
            view.presentScene(scene)
            
            // Set all ZPositions to 0 and make ovjects overlap
            view.ignoresSiblingOrder = true
        }
    }
}
