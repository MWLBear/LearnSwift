//
//  IceBulletNode.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/9/27.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import SpriteKit

class IceBulletNode: SKSpriteNode, BulletProtocol {
	
	weak var monster: SKSpriteNode?
	
	var flySpeed: CGFloat {
		get {
			return 400
		}
	}
	
	var contactIsRemove: Bool {
		get {
			return false
		}
	}
	
	func runAnimation() {
		run(SKAction.repeatForever(SKAction.animate(with: attackTextures, timePerFrame: 0.1, resize: true, restore: false)))
	}
	
	var atk: Int = 50
	
	static func newNode() -> IceBulletNode {
		let node = IceBulletNode.init(texture: nil, color: UIColor.clear, size: CGSize.init(width: 30, height: 43))
		return node
	}
	
	lazy var attackTextures: [SKTexture] = {
		var arr = [SKTexture]()
		arr.append(SKTexture.init(imageNamed: "bullet2-1"))
		arr.append(SKTexture.init(imageNamed: "bullet2-2"))
		arr.append(SKTexture.init(imageNamed: "bullet2-3"))
		return arr
	}()
	
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
