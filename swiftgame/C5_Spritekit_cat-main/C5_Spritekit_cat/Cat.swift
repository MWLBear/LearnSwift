//
//  Cat.swift
//  C5_Spritekit_cat
//
//  Created by mac12 on 2022/3/23.
//

import UIKit
import SpriteKit

class Cat: SKSpriteNode {
    let textureAtlas = SKTextureAtlas(named: "db.atlas")
    var textureFrames = [SKTexture]()
    
    override init(texture: SKTexture?, color: SKColor, size: CGSize) {
        let texture = SKTexture(imageNamed: "db_02.png")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        var tempName: String
        for i in 1...textureAtlas.textureNames.count {
            tempName = String(format: "db_%.2d", i)
            let dbTexture = textureAtlas.textureNamed(tempName)
            textureFrames.append(dbTexture)
        }
        
        anchorPoint = CGPoint(x: 0.5, y: 0.2)
        showAtlas()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func showAtlas() {
        self.run(SKAction.repeatForever(SKAction.animate(with: textureFrames, timePerFrame: 0.2)))
    }
}
