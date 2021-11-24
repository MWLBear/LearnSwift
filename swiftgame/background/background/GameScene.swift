//
//  GameScene.swift
//  background
//
//  Created by admin on 2021/10/19.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        createGrounds()
        addSprikit()
        print((self.scene?.size.width)!)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveGround()
    }
    
    func addSprikit(){
        let sk  = SKSpriteNode(imageNamed: "sk-1")
        sk.anchorPoint = CGPoint(x: 0.5, y: 0)
        sk.position = CGPoint(x: 100, y: -40)
        addChild(sk)
        
        let playButton = SKSpriteButton(defaultButtonImage: "playButton", action: goToLevelScene)
        playButton.position = CGPoint(x: -100, y: frame.midY)
        playButton.setScale(0.2)
        addChild(playButton)
    }
    func goToLevelScene(_: Int) {
        let scene = SKScene(fileNamed: "LevelScene") as? LevelScene
        scene?.touchAction = { level in
            print("等级:\(level)")
           

        }
        self.view?.presentScene(scene)
    }
    
    func createGrounds(){
        for i in 0...3 {
            let ground = SKSpriteNode(imageNamed: "gr")
            ground.name = "Ground"
            ground.size = CGSize(width: self.frame.size.width, height: 160)
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            ground.position = CGPoint(x: CGFloat(i)*ground.size.width, y: -(self.size.height / 2 ) + 50)
            addChild(ground)
        }
    }
    
    func moveGround(){
        enumerateChildNodes(withName: "Ground") { noode, _ in
            noode.position.x -= 2
            if noode.position.x < -((self.scene?.size.width)!){
                noode.position.x += (self.scene?.size.width)! * 3
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view?.presentScene(ScrollScene(size: self.size))
    }
}
