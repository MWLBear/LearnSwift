//
//  TopBarNode.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/8/22.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import SpriteKit

class TopBarNode: SKSpriteNode {

	public var totalWaveNum: Int = 0
	public var currentWaveNum: Int = 0 {
		didSet {
			waveCountLabel.text = "\(currentWaveNum)/\(totalWaveNum)"
		}
	}
	
	public var lifeNum: Int = 0 {
		didSet {
			lifeCountLabel.text = "\(lifeNum)"
		}
	}
	
	public var moneyNum: Int = 0 {
		didSet {
			moneyCountLabel.text = "\(moneyNum)"
		}
	}
	
	static func newNode() -> TopBarNode {
		let node = TopBarNode.init(texture: SKTexture.init(imageNamed: "map_UI-hd"), color: UIColor.clear, size: CGSize.init(width: 960, height: 70))
		return node
	}
	
	private lazy var waveCountLabel: SKLabelNode = {
		let node = self.newLabel()
		node.position = CGPoint.init(x: -350, y: 0)
		return node
	}()
	
	private lazy var lifeCountLabel: SKLabelNode = {
		let node = self.newLabel()
		node.position = CGPoint.init(x: -75, y: 0)
		return node
	}()
	
	private lazy var moneyCountLabel: SKLabelNode = {
		let node = self.newLabel()
		node.position = CGPoint.init(x: 175, y: 0)
		return node
	}()
	
	private func newLabel() -> SKLabelNode {
		let node = SKLabelNode.init(fontNamed: "AlphaEcho")
		node.horizontalAlignmentMode = .center
		node.verticalAlignmentMode = .center
		node.text = "0"
		node.fontColor = UIColor.black
		node.fontSize = 30
		node.zPosition = 12
		return node
	}
	
	override init(texture: SKTexture?, color: UIColor, size: CGSize) {
		super.init(texture: texture, color: color, size: size)
		addChild(waveCountLabel)
		addChild(lifeCountLabel)
		addChild(moneyCountLabel)
		self.zPosition = 11;
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

