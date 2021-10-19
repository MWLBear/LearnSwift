//
//  GuideNode.swift
//  sanguocount
//
//  Created by admin on 2021/10/13.
//

import SpriteKit

class GuideNode: SKSpriteNode {
    
    init(positionInit:CGPoint) {
        let texture = SKTexture(imageNamed: "tips")
        super.init(texture: texture,color: .black,size: texture.size())
        position = positionInit
        zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
