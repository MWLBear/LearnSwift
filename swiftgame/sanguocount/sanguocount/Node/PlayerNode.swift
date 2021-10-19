//
//  PlayerNode.swift
//  sanguocount
//
//  Created by admin on 2021/10/12.
//

import SpriteKit

class PlayerNode: SKSpriteNode {
    
    init(positionInit:CGPoint,showBg:Bool,atlasName:String) {
        var frames:[SKTexture] = []
        let atlas = SKTextureAtlas(named: atlasName)
        for index in 1...atlas.textureNames.count {
            frames.append(atlas.textureNamed("\(atlasName)_\(index)"))
        }
        let texture = frames[0]
        let tsize = texture.size().width > 700 ? CGSize(width: 120, height: 140): texture.size()
        
        super.init(texture: texture,color: .black,size: tsize)
        position = positionInit
        zPosition = 1
        run(SKAction.repeatForever(SKAction.animate(with: frames, timePerFrame: 0.1)))
        
        let bgNode = SKSpriteNode(texture: SKTexture(imageNamed: "slelect"), size: CGSize(width: 250, height: 120))
        bgNode.zPosition = -1
        showBg ? addChild(bgNode) : nil
        
        if(!showBg){
            configPlayer()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configPlayer (){
        self.name = "player"
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = PhysicsCategory.player
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.contactTestBitMask = PhysicsCategory.yb | PhysicsCategory.enemy
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 2
    }
    
    func remove(){
        let scaleUp = SKAction.scale(by: 1.2, duration: 0.15)
        let scaleDown = scaleUp.reversed()
        let fullScale = SKAction.sequence(
            [scaleUp, scaleDown, scaleUp, scaleDown])
        let group = SKAction.group([fullScale])
        let groupWait = SKAction.repeat(group, count: 1)
        let disappear = SKAction.scale(to: 0, duration: 0.15)
        let removeFromParent = SKAction.removeFromParent()
        let actions = [groupWait, disappear, removeFromParent]
        run(SKAction.sequence(actions))
    }
    
}
