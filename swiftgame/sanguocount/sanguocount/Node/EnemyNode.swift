//
//  EnemyNode.swift
//  sanguocount
//
//  Created by admin on 2021/10/19.
//

import UIKit
import SpriteKit

class EnemyNode: SKSpriteNode {
    
    var isenemy: Bool
    init(name:String,isenemy:Bool) {
        self.isenemy = isenemy
        
        let number1 = Int.random(in: 1 ... 3)
        let nodeName = isenemy ? "enemy\(number1)" : name
        let texture = SKTexture(imageNamed: nodeName)
        
        super.init(texture: texture,color: .clear,size: texture.size())
        self.setScale(isenemy ? 0.4 : 0.9)
        self.name = nodeName
        self.physicsBody = SKPhysicsBody(rectangleOf: texture.size())
        self.physicsBody?.categoryBitMask = isenemy ? PhysicsCategory.enemy : PhysicsCategory.yb
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func spawnMovie(isHard:Bool){
        let emovieDuration = isHard ? CGFloat.random(in: 0.8 ... 1.0) : CGFloat.random(in: 1.8 ... 2.2)
        let pmovieDuration = isHard ? CGFloat.random(in: 0.8 ... 1.0) : CGFloat.random(in: 2.0 ... 2.5)

        let moveLeft = SKAction.moveTo(x: 50, duration: 3.0)
        moveLeft.timingMode = .easeInEaseOut
        let moveRight = SKAction.moveTo(x: USize.width - 50.0, duration: 3.0)
        moveRight.timingMode = .easeInEaseOut
        let randomNumber = Int(arc4random_uniform(2))
        let asideMovementSequence = randomNumber == 0 ? SKAction.sequence([moveLeft, moveRight]) : SKAction.sequence([moveRight, moveLeft])
        let foreverAsideMovement = SKAction.repeatForever(asideMovementSequence)

        let actionMove = SKAction.moveTo(y: -size.height / 2, duration: self.isenemy ? emovieDuration : pmovieDuration)
        actionMove.timingMode = .easeInEaseOut
        let actionRemove = SKAction.removeFromParent()
        let actionWait = SKAction.wait(forDuration: isenemy ? 2.0 : 1.0)
        let actions = [actionMove, actionRemove,actionWait]
        let sq = SKAction.sequence(actions)
        run(SKAction.group([foreverAsideMovement,sq]))
    }
}
