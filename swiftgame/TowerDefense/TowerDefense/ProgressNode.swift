//
//  ProgressNode.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/8/10.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import SpriteKit

class ProgressNode: SKSpriteNode {

	static func newNode() -> ProgressNode {
		let node = ProgressNode.init(texture: nil, color: UIColor.clear, size: CGSize.init(width: 40, height: 5))
		return node
	}

	private lazy var bgNode: SKSpriteNode = {
		let node = SKSpriteNode.init(texture: nil, color: UIColor.white, size: self.size)
		node.zPosition = 1
		return node
	}()
	
	private lazy var progressNode: SKSpriteNode = {
		let node = SKSpriteNode.init(texture: nil, color: UIColor.red, size: self.size)
		node.anchorPoint = CGPoint.zero
		node.position = CGPoint.init(x: -node.size.width * 0.5, y: -node.size.height * 0.5)
		node.zPosition = 2
		return node
	}()
	
	private(set) var progress: CGFloat = 1
	
	func setPregress(_ progress: CGFloat, animated: Bool) {
		var p = progress
		if p > 1 {
			p = 1
		} else if p < 0 {
			p = 0
		}
		self.progress = p
		progressNode.removeAllActions()
		progressNode.run(SKAction.resize(toWidth: self.size.width * p, duration: animated ? 0.3 : 0))
	}
	
	override init(texture: SKTexture?, color: UIColor, size: CGSize) {
		super.init(texture: texture, color: color, size: size)
		addChild(bgNode)
		addChild(progressNode)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
