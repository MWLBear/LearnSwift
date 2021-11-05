//
//  StartScene.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/8/13.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import SpriteKit

class StartScene: SKScene {
	lazy var bgNode: SKSpriteNode = {
		let node = SKSpriteNode.init(imageNamed: "show_menu_bg-hd")
		node.size = self.size
		node.anchorPoint = CGPoint.zero
		node.zPosition = -1
		return node
	}()
	
	lazy var audioNode: SKAudioNode = {
		let node = SKAudioNode.init(fileNamed:"BGM.mp3")
		node.isPositional = true
		return node
	}()
	
	lazy var startNode: ButtonNode = {
		let node = ButtonNode.init(size: CGSize.init(width: 255, height: 79))
		node.normalTexture = TextureAtlasManager.shared.uiAtlas?.textureNamed("play1")
		node.selectedTexture = TextureAtlasManager.shared.uiAtlas?.textureNamed("play")
		node.clickAction = { [weak self] (node) in
			self?.gotoGameScene()
		}
		node.anchorPoint = CGPoint.init(x: 1, y: 1)
		node.position = CGPoint.init(x: self.size.width - 50, y: self.size.height - 100)
		return node
	}()
	
	public var startAction: (() -> Void)?
	
	deinit {
		print("StartScene - deinit")
	}
	var isFirst: Bool = true
	override func didMove(to view: SKView) {
		super.didMove(to: view)
		guard isFirst else { return }
		isFirst = false
		addChild(audioNode)
	}
	
	override init(size: CGSize) {
		super.init(size: size)
		addChild(bgNode)
		addChild(startNode)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func gotoGameScene() {
		startAction?()
	}
}
