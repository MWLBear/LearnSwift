//
//  SettingNode.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/8/30.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import SpriteKit

class SettingNode: SKSpriteNode {

	public var quitAction: (() -> Void)?
	
	public var restartAction: (() -> Void)?
	
	lazy var contentNode: SKSpriteNode = {
		let node = SKSpriteNode.init(texture: TextureAtlasManager.shared.uiAtlas?.textureNamed("function_bg"), size: CGSize.init(width: 403 , height: 234 ))
		node.position = CGPoint.init(x: self.size.width * 0.5, y: self.size.height * 0.5)
		return node
	}()
	
	lazy var restartBtn: ButtonNode = {
		let node = ButtonNode.init(size: CGSize.init(width: 160 , height: 57 ))
		node.normalTexture = TextureAtlasManager.shared.uiAtlas?.textureNamed("restart")
		node.selectedTexture = TextureAtlasManager.shared.uiAtlas?.textureNamed("restart1")
		node.position = CGPoint.init(x: 85 , y: -50 )
		node.zPosition = self.zPosition + 1
		node.clickAction = { [weak self] (node) in
			self?.dismiss()
			self?.restartAction?()
		}
		return node
	}()
	
	lazy var quitBtn: ButtonNode = {
		let node = ButtonNode.init(size: CGSize.init(width: 160 , height: 57 ))
		node.normalTexture = TextureAtlasManager.shared.uiAtlas?.textureNamed("quit")
		node.selectedTexture = TextureAtlasManager.shared.uiAtlas?.textureNamed("quit1")
		node.position = CGPoint.init(x: -85 , y: -50 )
		node.zPosition = self.zPosition + 1
		node.clickAction = { [weak self] (node) in
			self?.dismiss()
			self?.quitAction?()
		}
		return node
	}()
	
	override init(texture: SKTexture?, color: UIColor, size: CGSize) {
		super.init(texture: texture, color: color, size: size)
		isUserInteractionEnabled = true
		anchorPoint = CGPoint.zero
		position = CGPoint.zero
		zPosition = 20
		addChild(contentNode)
		contentNode.addChild(restartBtn)
		contentNode.addChild(quitBtn)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func showAt(scene: SKScene) {
		if self.parent == nil {
			self.alpha = 0
			scene.addChild(self)
			self.run(SKAction.fadeAlpha(to: 1, duration: 0.3))
		}
	}
	
	func dismiss() {
		self.run(SKAction.fadeAlpha(to: 0, duration: 0.3)) {
			self.removeFromParent()
		}
	}
}
