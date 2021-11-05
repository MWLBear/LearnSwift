//
//  Road.swift
//  Cars
//
//  Created by Suresh Thotakura on 08/05/2020.
//  Copyright © 2020 Neharjun Technologies Limited. All rights reserved.
//

import UIKit
import SpriteKit

class Road: SKSpriteNode {
    let roadSpeed = CGFloat(8)

    init(size: CGSize, position: CGPoint) {
        let texture = SKTexture(imageNamed: "road")
        super.init(texture: texture, color: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0), size: texture.size())

        self.name = "road"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.zPosition = ZPositions.road
        self.size = size
        self.position = position
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func move() {
        position.y -= roadSpeed

        if (position.y + size.height < scene!.frame.minY) {
            position.y += scene!.frame.size.height * 3
        }
    }
}
