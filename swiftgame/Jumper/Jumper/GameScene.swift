//
//  GameScene.swift
//  Jumper
//
//  Created by Mykola Maslov on 10/6/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var sky: EndlessBackground!
    var forest: EndlessBackground!
    var ground: EndlessBackground!
    var girl: SKSpriteNode!
    var dino: SKSpriteNode!
    
    var isOver = false
    var score = 0
    
    override func didMove(to view: SKView) {
        sky = EndlessBackground(parent: self, sprite: self.childNode(withName: "sky") as! SKSpriteNode, speed: 1)
        forest = EndlessBackground(parent: self, sprite: self.childNode(withName: "forest") as! SKSpriteNode, speed: 3)
        ground = EndlessBackground(parent: self, sprite: self.childNode(withName: "ground") as! SKSpriteNode, speed: 6)
        
        girl = self.childNode(withName: "girl") as? SKSpriteNode
        dino =  self.childNode(withName: "dino") as? SKSpriteNode
        
        
        let backgroundMusic = SKAudioNode(fileNamed: "theme.mp3")
        backgroundMusic.autoplayLooped = true
        self.addChild(backgroundMusic)
        
        let dinoMove = SKAction.moveTo(x: -783, duration: 5)
        dino.run(dinoMove, withKey: "dino_run")
        
        physicsWorld.contactDelegate = self
    }
    
    override func update(_ currentTime: TimeInterval) {
        sky.update()
        forest.update()
        ground.update()
        updateDino()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if girl.physicsBody?.velocity.dy == 0 && !isOver {
            self.run(SKAction.playSoundFileNamed("hit.wav", waitForCompletion: false))
            girl.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
        }
        
        if isOver {
            for touch in touches {
                let homeButton = self.childNode(withName: "home") as! SKSpriteNode
                if homeButton.contains(touch.location(in: self)) {
                    //Move palyer to the Menu scene
                    if let scene = SKScene(fileNamed: "MenuScene") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFit
                        
                        // Present the scene
                        self.view?.presentScene(scene, transition: .doorsOpenVertical(withDuration: 1))
                    }
                }
            }
        }
    }
    
    func updateDino() {
        if dino.position.x + dino.size.width < 0 {
            self.run(SKAction.playSoundFileNamed("dinosaur.wav", waitForCompletion: false))
            dino.position.x = self.size.width
            
            score += 1
            let scoreLabel = self.childNode(withName: "score") as! SKLabelNode
            scoreLabel.text = "Score: \(score)"
            
            dino.removeAction(forKey: "dino_run")
            let randomTime = TimeInterval(arc4random_uniform(5) + 2)
            let dinoMove = SKAction.moveTo(x: -783, duration: randomTime)
            dino.run(dinoMove, withKey: "dino_run")
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == 2 | 4 {
            gameOver()
        }
    }
    
    func gameOver() {
        isOver = true
        showGameOver()
        dino.removeAllActions()
        girl.removeAllActions()
        
        ground.stop()
        forest.stop()
        sky.stop()
    }
    
    func showGameOver() {
        let gameOverLabel = self.childNode(withName: "game_over") as? SKLabelNode
        let homeButton = self.childNode(withName: "home") as? SKSpriteNode
        
        print(self.size.width)
        gameOverLabel?.position.x = self.size.width/2
        homeButton?.position.x = self.size.width/2
    }
    
}
