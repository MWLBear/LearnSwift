//
//  TrafficCar.swift
//  Cars
//
//  Created by Suresh Thotakura on 15/04/2020.
//  Copyright © 2020 Neharjun Technologies Limited. All rights reserved.
//

import SpriteKit

class TrafficCar : Car {
    var row: Int = 0
    var initialPosition = CGPoint()
    
    init(imageNamed: String, row: Int, lane: Int, position: CGPoint, carSpeed: CGFloat = 5.0) {
        super.init(imageNamed: imageNamed, carSpeed: carSpeed, lane: lane)
        
        self.name = "traffic"
        self.row = row
        self.initialPosition = position
        
        self.position = position
        self.zPosition = ZPositions.cars
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCategory.traffic
        physicsBody?.contactTestBitMask = PhysicsCategory.none
        physicsBody?.collisionBitMask = PhysicsCategory.player | PhysicsCategory.traffic | PhysicsCategory.edge
        physicsBody?.restitution = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func move(laneTraffic: [TrafficCar]) {
        position.y -= carSpeed

        if position.y + size.height < scene!.frame.minY {
            var newY = scene!.frame.maxY + initialPosition.y

            for laneCar in laneTraffic {
                if abs(newY - laneCar.position.y) < Car.DefaultSize.height {
                    newY = laneCar.position.y + Car.DefaultSize.height + 50
                }
            }

            position.y = newY
            texture = SKTexture(imageNamed: Cars.names.randomElement()!)
        }
    }

    func increaseSpeed() {
        carSpeed += 1
    }
}
