//
//  Background.swift
//  WarFly(SpriteKit)
//
//  Created by Oleg Kanatov on 11.10.21.
//

import SpriteKit

class Background: SKSpriteNode {
    
    static func populateBackground(at point: CGPoint) -> Background {
        
        let background = Background(imageNamed: "background")
        background.position = point
        background.zPosition = 0
        
        return background
    }
    
}
