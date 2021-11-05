//
//  DragSignNode.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/10/15.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import SpriteKit

class DragSignNode: SKSpriteNode {
	
	var yuan: SKShapeNode?
	
	lazy var towerNode: SKSpriteNode = {
		let node = SKSpriteNode.init(texture: nil, color: UIColor.clear, size: CGSize.init(width: 100, height: 100))
		node.zPosition = self.zPosition + 2
		return node
	}()
	
	lazy var hTiao: SKSpriteNode = {
		let node = SKSpriteNode.init(texture: nil, color: UIColor.red.withAlphaComponent(0.3), size: CGSize.init(width: self.size.width, height: 50))
		node.anchorPoint = CGPoint.init(x: 0, y: 0.5)
		node.zPosition = self.zPosition + 1
		return node
	}()
	
	lazy var vTiao: SKSpriteNode = {
		let node = SKSpriteNode.init(texture: nil, color: UIColor.red.withAlphaComponent(0.3), size: CGSize.init(width: 50, height: self.size.height))
		node.anchorPoint = CGPoint.init(x: 0.5, y: 0)
		node.zPosition = self.zPosition + 1
		return node
	}()
	
	override init(texture: SKTexture?, color: UIColor, size: CGSize) {
		super.init(texture: texture, color: color, size: size)
		anchorPoint = CGPoint.zero
		addChild(hTiao)
		addChild(vTiao)
		addChild(towerNode)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setTowerPosition(_ point: CGPoint) {
		hTiao.position = CGPoint.init(x: 0, y: point.y)
		vTiao.position = CGPoint.init(x: point.x, y: 0)
		yuan?.position = point
		towerNode.position = point
	}
	
	func willSetTower(type: TowerType) {
		isHidden = false
		towerNode.texture = SKTexture.init(imageNamed: "tower\(type.rawValue)_n_1")
		let config = TowerConfig.init(type: type, level: .level1)
		let node = SKShapeNode.init(circleOfRadius: config.atkRange)
		node.fillColor = UIColor.lightGray.withAlphaComponent(0.5)
		node.zPosition = self.zPosition + 1
		addChild(node)
		yuan = node
	}
	
	func didSetTower() {
		isHidden = true
		yuan?.removeFromParent()
		yuan = nil
	}
	
	func setIsEnable(_ isEnable: Bool) {
		let color = (isEnable ? UIColor.green : UIColor.red).withAlphaComponent(0.2)
		hTiao.color = color
		vTiao.color = color
	}
	
}
