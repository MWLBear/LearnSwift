//
//  TowerNode.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/8/9.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import SpriteKit
import AudioToolbox

enum TowerNodeState {
	case normal
	case attack
}

enum TowerLevel: Int {
	case level1 = 1
	case level2 = 2
	case level3 = 3
}

enum TowerType: Int {
	case machine = 1
	case ice = 2
	case magnetic = 3
	case missile = 4
}

struct TowerConfig {
	
	var atkRange: CGFloat = 0
	var atkDuration: TimeInterval = 0
	var atkValue: Int = 0
	var sellMoney: Int = 0
	var upgradeMoney: Int = 0
	
	var type: TowerType
	var level: TowerLevel
	
	init(type: TowerType, level: TowerLevel) {
		self.type = type
		self.level = level
		
		switch type {
		case .machine:
			switch level {
			case .level1:
				atkRange = 150
				atkDuration = 0.3
				atkValue = 10
				sellMoney = 8
				upgradeMoney = 15
				
			case .level2:
				atkRange = 200
				atkDuration = 0.2
				atkValue = 15
				sellMoney = 20
				upgradeMoney = 20
				
			case .level3:
				atkRange = 250
				atkDuration = 0.1
				atkValue = 20
				sellMoney = 36
				upgradeMoney = 0
			}
			
		case .ice:
			switch level {
			case .level1:
				atkRange = 150
				atkDuration = 1
				atkValue = 5
				sellMoney = 8
				upgradeMoney = 15
				
			case .level2:
				atkRange = 200
				atkDuration = 0.8
				atkValue = 10
				sellMoney = 20
				upgradeMoney = 20
				
			case .level3:
				atkRange = 250
				atkDuration = 0.5
				atkValue = 15
				sellMoney = 36
				upgradeMoney = 0
			}
			
		case .magnetic:
			switch level {
			case .level1:
				atkRange = 150
				atkDuration = 0.1
				atkValue = 20
				sellMoney = 16
				upgradeMoney = 25
				
			case .level2:
				atkRange = 200
				atkDuration = 0.1
				atkValue = 25
				sellMoney = 36
				upgradeMoney = 30
				
			case .level3:
				atkRange = 250
				atkDuration = 0.1
				atkValue = 30
				sellMoney = 60
				upgradeMoney = 0
			}
			
		case .missile:
			switch level {
			case .level1:
				atkRange = 200
				atkDuration = 1
				atkValue = 50
				sellMoney = 40
				upgradeMoney = 60
				
			case .level2:
				atkRange = 250
				atkDuration = 0.8
				atkValue = 70
				sellMoney = 88
				upgradeMoney = 70
				
			case .level3:
				atkRange = 300
				atkDuration = 0.6
				atkValue = 100
				sellMoney = 144
				upgradeMoney = 0
			}
		}
	}
}

class TowerNode: ButtonNode {
	
	override var isPaused: Bool {
		didSet {
			print("ddd");
		}
	}

	public var attackAction: ((TowerNode, MonsterNode?) -> Void)?
	
	public var getAllMonster: (() -> Set<MonsterNode>)!
	
	private var state: TowerNodeState = .normal
	
	private(set) var audioName: String?
	
	private(set) var bodyTexture: SKTexture?
	
	private(set) var currentMonster: MonsterNode?
	
	private(set) var type: TowerType
	
	private(set) var level: TowerLevel = .level1
	
	private(set) var config: TowerConfig = TowerConfig.init(type: TowerType.machine, level: .level1)
	
	private var attackTextures: [SKTexture] = [SKTexture]()
	
	func initConfig(level: TowerLevel = .level1) {
		self.config = TowerConfig.init(type: type, level: level)
		self.level = level
		attackTextures.removeAll()
		var anchorPoint = CGPoint.zero
		switch type {
		case .machine:
			audioName = "machineGun.mp3"
			anchorPoint = CGPoint.init(x: 0.5, y: 0.4)
			
		case .ice:
			audioName = "iceGun.wav"
			anchorPoint = CGPoint.init(x: 0.5, y: 0.5)

		case .magnetic:
			audioName = "magneticGun.wav"
			anchorPoint = CGPoint.init(x: 0.5, y: 0.4)
			
		case .missile:
			audioName = "missileGun.mp3"
			anchorPoint = CGPoint.init(x: 0.5, y: 0.4)
		}
		
		let nor = SKTexture.init(imageNamed: "tower\(type.rawValue)_n_\(level.rawValue)")
		let fire = SKTexture.init(imageNamed: "tower\(type.rawValue)_h_\(level.rawValue)")
		bodyTexture = nor
		attackTextures.append(fire)
		attackTextures.append(nor)
		
		bodyNode.texture = bodyTexture
		bodyNode.anchorPoint = anchorPoint
		
		let fireAction = SKAction.animate(with: attackTextures, timePerFrame: 0.1, resize: false, restore: false)
		let resumeAction = SKAction.wait(forDuration: config.atkDuration)
		self.fireAction = SKAction.group([fireAction, resumeAction])
	}

	lazy var bodyNode: SKSpriteNode = {
		let node = SKSpriteNode.init(texture: bodyTexture, color: UIColor.clear, size: CGSize.init(width: 100, height: 100))
		node.anchorPoint = CGPoint.init(x: 0.5, y: 0.4)
		return node
	}()
	
	lazy var lightningNode: LightningNode = {
		let node = LightningNode.newNode()
		node.isHidden = true
		node.position = CGPoint.init(x: 0, y: 35)
		return node
	}()
	
	static func newNode(type: TowerType) -> TowerNode {
		let node = TowerNode.init(type: type)
		return node
	}

	init(type: TowerType) {
		self.type = type
		super.init(texture: nil, color: UIColor.clear, size: CGSize.init(width: 100, height: 100))
		initConfig()
		zPosition = 20
		addChild(bodyNode)
		if type == .magnetic {
			bodyNode.addChild(lightningNode)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	var canAttach: Bool = true
	
	var fireAction: SKAction!
	
	var soundId: SystemSoundID?
	
	func playSound() {
		if let sid = soundId {
			AudioServicesPlaySystemSound(sid)
		} else if let soundURL = Bundle.main.url(forResource: audioName, withExtension: nil) {
			var mySound: SystemSoundID = 0
			AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
			soundId = mySound
			AudioServicesPlaySystemSound(mySound)
		}
	}
	
	func runAttackAnimation() {
		if state != .attack {
			state = .attack
			bodyNode.run(fireAction) { [weak self] in
				self?.state = .normal
			}
			playSound()
			attackAction?(self, currentMonster)
		}
	}
	
	func runLightningAttackAnimation() {
		if state != .attack {
			state = .attack
			bodyNode.run(fireAction) { [weak self] in
				self?.state = .normal
			}
			attackAction?(self, currentMonster)
		}
	}
	
	/// 升级
	func upgrade() {
		if level == .level1 {
			initConfig(level: .level2)
		} else if level == .level2 {
			initConfig(level: .level3)
		}
	}
	
	let rotate5Action = SKAction.rotate(byAngle: CGFloat(5).toHuDu, duration: 0)
	let rotate_5Action = SKAction.rotate(byAngle: CGFloat(-5).toHuDu, duration: 0)
	
	func update(_ currentTime: TimeInterval) {
		var needSearch = false
		if let c = currentMonster, c.parent != nil, !c.isDie {
			if (c.position.distance(to: self.position) > self.config.atkRange) {
				needSearch = true
			}
		} else {
			needSearch = true
		}
		if needSearch {
			self.currentMonster = nil
			let all = self.getAllMonster()
			var tempMonster: MonsterNode?
			for monster in all {
				let distance = monster.position.distance(to: self.position)
				if (distance < self.config.atkRange) {
					if let temp = tempMonster {
						if temp.position.distance(to: self.position) > distance {
							tempMonster = monster
						}
					} else {
						tempMonster = monster
					}
				}
			}
			self.currentMonster = tempMonster
		}
		DispatchQueue.main.async {
			self.tryAttack()
		}
	}
	
	func tryAttack() {
		if let c = currentMonster {
			let toAngle = Int(self.position.angle(to: c.position).toJiaoDu) % 360
			let currentAngle = Int(self.bodyNode.zRotation.toJiaoDu) % 360
			if abs(toAngle - currentAngle) < 10 {
				bodyNode.run(SKAction.rotate(toAngle: self.position.angle(to: c.position), duration: 0, shortestUnitArc: true))
				if type == .magnetic {
					lightningNode.isHidden = false
					lightningNode.size = CGSize.init(width: 60, height: self.position.distance(to: c.position) - 20)
					runLightningAttackAnimation()
				} else {
					runAttackAnimation()
				}
			} else {
				if type == .magnetic {
					lightningNode.isHidden = true
				}
				if toAngle > currentAngle {
					if toAngle - currentAngle < 180 {
						bodyNode.run(rotate5Action)
					} else {
						bodyNode.run(rotate_5Action)
					}
				} else {
					if currentAngle - toAngle < 180 {
						bodyNode.run(rotate_5Action)
					} else {
						bodyNode.run(rotate5Action)
					}
				}
			}
		} else {
			if type == .magnetic {
				lightningNode.isHidden = true
			}
		}
	}
}
