//
//  LightningNode.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/10/9.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import SpriteKit

class LightningNode: SKSpriteNode {

	static func newNode() -> LightningNode {
		let node = LightningNode.init(texture: SKTexture.init(imageNamed: "bulletEffect3-1"), color: UIColor.clear, size: CGSize.init(width: 60, height: 180))
		return node
	}

	lazy var audioNode: SKAudioNode = {
		let node = SKAudioNode.init(fileNamed: "magneticGun.wav")
		node.autoplayLooped = true
		node.isPositional = false
		node.isHidden = true
		return node
	}()
	
	override var isHidden: Bool {
		didSet {
			if isHidden {
				audioNode.removeFromParent()
			} else {
				if audioNode.parent == nil {
					addChild(audioNode)
				}
			}
		}
	}
	
	override init(texture: SKTexture?, color: UIColor, size: CGSize) {
		super.init(texture: texture, color: color, size: size)
		anchorPoint = CGPoint.init(x: 0.5, y: 0)
		run(SKAction.repeatForever(SKAction.animate(with: [SKTexture.init(imageNamed: "bulletEffect3-1"), SKTexture.init(imageNamed: "bulletEffect3-2"), SKTexture.init(imageNamed: "bulletEffect3-3")], timePerFrame: 0.1, resize: false, restore: false)))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
