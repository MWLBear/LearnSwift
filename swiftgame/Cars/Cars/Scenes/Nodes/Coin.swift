//
//  Coin.swift
//  Cars
//
//  Created by Suresh Thotakura on 17/04/2020.
//  Copyright © 2020 Neharjun Technologies Limited. All rights reserved.
//

import SpriteKit

class Coin : SKSpriteNode {
    enum Coins {
        static let types = [
            "a", "n"
        ]
    }

    static let DefaultSize = CGSize(width: 30, height: 30)
    
    let coinSpeed = CGFloat(8)
    let score = 1
    let actions = SKAction.sequence([
        SKAction.scale(to: 0.85, duration: 0.25),
        SKAction.wait(forDuration: 0.25),
        SKAction.scale(to: 1.0, duration: 0.25)])

    var type : String
    var collected : Bool = false
    
    init(position: CGPoint) {
        self.type = Coins.types.randomElement()!

        let texture = SKTexture(imageNamed: "coin-" + self.type)
        super.init(texture: texture, color: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0), size: texture.size())
        
        self.name = "coin"
        self.size = Coin.DefaultSize
        self.position = position
        self.zPosition = ZPositions.coins

        physicsBody = SKPhysicsBody(circleOfRadius: size.height / 2)
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCategory.coin
        physicsBody?.contactTestBitMask = PhysicsCategory.none
        physicsBody?.collisionBitMask = PhysicsCategory.none

        run(SKAction.repeatForever(actions))
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func move() {
        if collected {
            collected = false
            position.y += scene!.frame.maxY * 3
        } else {
            position.y -= coinSpeed

            if(position.y + size.height < scene!.frame.minY) {
                position.y += scene!.frame.maxY * 3
            }
        }
    }

    func collect() {
        collected = true

        if let collectionEmitter = SKEmitterNode(fileNamed: GameConfig.Particles.Collection) {
            collectionEmitter.position = position
            scene!.addChild(collectionEmitter)

            let removeAction = SKAction.sequence([SKAction.wait(forDuration: 2), SKAction.removeFromParent()])
            collectionEmitter.run(removeAction)
        }

        run(GameSounds.sharedInstance.collectCoin)
    }
}
