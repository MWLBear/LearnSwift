//
//  MachineBulletNode.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/9/26.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import SpriteKit

class MachineBulletNode: SKSpriteNode, BulletProtocol {
	
	var flySpeed: CGFloat {
		get {
			return 1000
		}
	}
	
	var contactIsRemove: Bool {
		get {
			return true
		}
	}
	
	func runAnimation() {
		
	}
	
	var atk: Int = 50
	
	static func newNode() -> MachineBulletNode {
		let node = MachineBulletNode.init(texture: SKTexture.init(imageNamed: "fire_effect1"), color: UIColor.clear, size: CGSize.init(width: 20, height: 20))
		return node
	}
	
	override init(texture: SKTexture?, color: UIColor, size: CGSize) {
		super.init(texture: texture, color: color, size: size)
		zPosition = 19
		self.physicsBody = {
			let body = SKPhysicsBody.init(circleOfRadius: 5)
			body.affectedByGravity = false
			body.allowsRotation = false
			body.usesPreciseCollisionDetection = true
			body.categoryBitMask = BodyType.bullet.rawValue
			body.collisionBitMask = 0
			body.contactTestBitMask = 0
			return body
		}()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
