//
//  Car.swift
//  Cars
//
//  Created by Suresh Thotakura on 15/04/2020.
//  Copyright © 2020 Neharjun Technologies Limited. All rights reserved.
//

import SpriteKit

class Car: SKSpriteNode {
    static let DefaultSize = CGSize(width: 52, height: 88.75)

    var lane: Int = 0
    var carSpeed: CGFloat
    var exhaustEffect = SKEffectNode()

    init(imageNamed: String, carSpeed: CGFloat = 0.0, lane: Int) {
        self.carSpeed = carSpeed
        self.lane = lane

        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0), size: texture.size())

        self.size = Car.DefaultSize
        self.zPosition = ZPositions.cars

        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCategory.player
        physicsBody?.contactTestBitMask = PhysicsCategory.traffic | PhysicsCategory.coin
        physicsBody?.collisionBitMask = PhysicsCategory.traffic | PhysicsCategory.edge
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func start() {
        if let exhaustEmitter = SKEmitterNode(fileNamed: GameConfig.Particles.Exhaust) {
            exhaustEffect.position = CGPoint(x: 0, y: -size.height / 2)
            exhaustEffect.zPosition = ZPositions.cars
            exhaustEffect.addChild(exhaustEmitter)

            addChild(exhaustEffect)
        }
    }

    func stop() {
        removeChildren(in: [exhaustEffect])
    }

    func crash() {
        run(GameSounds.sharedInstance.crash)

        if let collisionEmitter = SKEmitterNode(fileNamed: GameConfig.Particles.Collision) {
            let collisionEffect = SKEffectNode()
            collisionEffect.position = CGPoint(x: 0, y: size.height / 4)
            collisionEffect.zPosition = ZPositions.smoke
            collisionEffect.addChild(collisionEmitter)

            addChild(collisionEffect)
        }

        stop()
    }
}

