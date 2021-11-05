//
//  MissileBombNode.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/9/29.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import SpriteKit
import AudioToolbox

class MissileBombNode: SKSpriteNode, BulletProtocol {
	
	var flySpeed: CGFloat {
		get {
			return 0
		}
	}
	
	var contactIsRemove: Bool {
		get {
			return false
		}
	}
	
	func runAnimation() {
		
	}
	
	func runAnimation(comleted: @escaping (() -> Void)) {
		playSound()
		self.run(action, completion: comleted)
	}
	
	var atk: Int = 50
	
	lazy var action: SKAction = {
		return SKAction.animate(with: attackTextures, timePerFrame: 0.1, resize: true, restore: true)
	}()
	
	lazy var attackTextures: [SKTexture] = {
		var arr = [SKTexture]()
		for i in 1...7 {
			arr.append(SKTexture.init(imageNamed: "explosionEffect\(i)"))
		}
		return arr
	}()
	
	var soundId: SystemSoundID?
	
	func playSound() {
		if let sid = soundId {
			AudioServicesPlaySystemSound(sid)
		} else if let soundURL = Bundle.main.url(forResource: "explosion3.mp3", withExtension: nil) {
			var mySound: SystemSoundID = 0
			AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
			soundId = mySound
			AudioServicesPlaySystemSound(mySound)
		}
	}
	
	static func newNode() -> MissileBombNode {
		let node = MissileBombNode.init(texture: nil, color: UIColor.clear, size: CGSize.init(width: 100, height: 100))
		return node
	}
	
	override init(texture: SKTexture?, color: UIColor, size: CGSize) {
		super.init(texture: texture, color: color, size: size)
		zPosition = 19
		self.physicsBody = {
			let body = SKPhysicsBody.init(circleOfRadius: 30)
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
