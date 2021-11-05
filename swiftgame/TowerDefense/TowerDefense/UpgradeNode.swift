//
//  UpgradeNode.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/10/8.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import SpriteKit

class UpgradeButtonNode: ButtonNode {
	
	lazy var textBaseNode: SKSpriteNode = {
		let node = SKSpriteNode.init(texture: SKTexture.init(imageNamed: "textBase"), size: CGSize.init(width: 50, height: 40))
		node.addChild(label)
		node.zPosition = self.zPosition + 1
		return node
	}()
	
	lazy var label: SKLabelNode = {
		let node = SKLabelNode.init(fontNamed: "AlphaEcho")
		node.horizontalAlignmentMode = .center
		node.verticalAlignmentMode = .center
		node.text = "0"
		node.fontColor = UIColor.black
		node.fontSize = 20
		node.zPosition = self.zPosition + 2
		return node
	}()
	
	override init(texture: SKTexture?, color: UIColor, size: CGSize) {
		super.init(texture: texture, color: color, size: size)
		addChild(textBaseNode)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class UpgradeNode: SKSpriteNode {
	
	public static func newNode() -> UpgradeNode {
		let node = UpgradeNode.init(texture: nil, color: UIColor.clear, size: CGSize.init(width: 100, height: 100))
		return node
	}
	
	public var sellTower: ((TowerNode?) -> Void)?
	
	public var upgradeTower: ((TowerNode?) -> Void)?
	
	public var getCurrentMoney: (() -> Int?)?
	
	private weak var currentTower: TowerNode?
	
	private lazy var sellNode: UpgradeButtonNode = {
		let node = UpgradeButtonNode.init(texture: nil, color: UIColor.clear, size: CGSize.init(width: 80, height: 80))
		node.normalTexture = SKTexture.init(imageNamed: "money_button")
		node.selectedTexture = SKTexture.init(imageNamed: "money_button1")
		node.zPosition = self.zPosition + 3
		node.anchorPoint = CGPoint.init(x: 0, y: 0.5)
		node.textBaseNode.position = CGPoint.init(x: 65, y: -30)
		node.clickAction = { [weak self] (node) in
			self?.removeFromParent()
			self?.sellTower?(self?.currentTower)
		}
		return node
	}()
	
	private lazy var upgradeNode: UpgradeButtonNode = {
		let node = UpgradeButtonNode.init(texture: nil, color: UIColor.clear, size: CGSize.init(width: 80, height: 80))
		node.normalTexture = SKTexture.init(imageNamed: "upgrade_button")
		node.selectedTexture = SKTexture.init(imageNamed: "upgrade_button1")
		node.zPosition = self.zPosition + 3
		node.anchorPoint = CGPoint.init(x: 1, y: 0.5)
		node.textBaseNode.position = CGPoint.init(x: -15, y: -30)
		node.clickAction = { [weak self] (node) in
			self?.removeFromParent()
			self?.upgradeTower?(self?.currentTower)
		}
		return node
	}()
	
	private lazy var currentRangeNode: SKSpriteNode = {
		let node = SKSpriteNode.init(texture: SKTexture.init(imageNamed: "range_new_c"), color: UIColor.clear, size: CGSize.init(width: 100, height: 100))
		node.zPosition = self.zPosition + 2
		return node
	}()
	
	override init(texture: SKTexture?, color: UIColor, size: CGSize) {
		super.init(texture: texture, color: color, size: size)
		self.zPosition = 30
		addChild(currentRangeNode)
		addChild(sellNode)
		addChild(upgradeNode)
		upgradeNode.color = UIColor.darkGray
		upgradeNode.colorBlendFactor = 1
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func setData(tower: TowerNode?) {
		guard let tower = tower else {
			return
		}
		currentTower = tower
		
		size = CGSize.init(width: tower.config.atkRange * 2, height: tower.config.atkRange * 2)
		currentRangeNode.size = size
		sellNode.position = CGPoint.init(x: -currentRangeNode.size.width * 0.5, y: 0)
		upgradeNode.position = CGPoint.init(x: currentRangeNode.size.width * 0.5, y: 0)
		sellNode.label.text = "\(tower.config.sellMoney)"
		upgradeNode.label.text = "\(tower.config.upgradeMoney)"
		currentMoneyChanged()
	}
	
	public func currentMoneyChanged() {
//		guard let tower = currentTower else {
//			return
//		}
//		if tower.config.upgradeMoney > 0 {
//			if let money = getCurrentMoney?(), money > tower.config.upgradeMoney {
//				upgradeNode.colorBlendFactor = 0
//			} else {
//				upgradeNode.colorBlendFactor = 1
//			}
//			upgradeNode.textBaseNode.isHidden = false
//		} else {
//			upgradeNode.colorBlendFactor = 1
//			upgradeNode.textBaseNode.isHidden = true
//		}
	}
	
}
