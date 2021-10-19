//
//  Background.swift
//  sanguocount
//
//  Created by admin on 2021/10/18.
//

import SpriteKit
import UIKit

let USize = UIScreen.main.bounds.size
class Background: SKSpriteNode {
    
    init(name:String) {
        let bg = SKTexture(imageNamed: name)
        super.init(texture: bg,color:.clear,size: USize)
        zPosition = -1
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        position = CGPoint(x: size.width/2, y: size.height/2)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
