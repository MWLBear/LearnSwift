//
//  SelectedMapScene.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/8/21.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import SpriteKit

class SelectedMapScene: SKScene {
	
	public var startGame: ((MapConfig) -> Void)?
	
	public var backAction: (() -> Void)?
	
	lazy var bgNode1: SKSpriteNode = {
		let node = SKSpriteNode.init(texture: SKTexture.init(imageNamed: "chooseMapBg-hd"), size: self.size)
		node.anchorPoint = CGPoint.zero
		node.zPosition = -1
		return node
	}()
	
	lazy var bgNode: SKSpriteNode = {
		let node = SKSpriteNode.init(texture: SKTexture.init(imageNamed: "mode_bg-hd"), size: self.size)
		node.anchorPoint = CGPoint.zero
		node.zPosition = 1
		return node
	}()
	
	lazy var previewNode: SKSpriteNode = {
		let node = SKSpriteNode.init(texture: SKTexture.init(imageNamed: currentMap.mapPreviewName), size: CGSize.init(width: 700, height: 374))
		node.zPosition = 0
		node.position = CGPoint.init(x: 475, y: 350)
		return node
	}()
	
	var currentMap: MapConfig = MapConfig.init(type: 6) {
		didSet {
			previewNode.texture = SKTexture.init(imageNamed: currentMap.mapPreviewName)
			selectedNode.removeFromParent()
			let node = smallMaps[currentMap.type - 1]
			node.addChild(selectedNode)
		}
	}
	
	lazy var selectedNode: SKSpriteNode = {
		let node = SKSpriteNode.init(texture: SKTexture.init(imageNamed: "select_frame-hd"), size: CGSize.init(width: 240, height: 135))
		node.zPosition = 2
		return node
	}()
	
	var smallMaps: [SmallMapNode] = [SmallMapNode]()
	
	lazy var scrollNode: ScrollNode = {
		let node = ScrollNode.init(texture: nil, color: UIColor.clear, size: CGSize.init(width: 250, height: 600))
		node.zPosition = 1
		node.position = CGPoint.init(x: 1050, y: 40)
		node.contentSize = CGSize.init(width: 250, height: 1810)
		node.contentOffset = CGPoint.init(x: 0, y: -1810 + 600)
		node.touchAction = { (point) in
			var mapConfig: MapConfig?
			for tempNode in self.smallMaps {
				if tempNode.frame.contains(point) {
					mapConfig = tempNode.mapConfig
					break
				}
			}
			if let ct = mapConfig {
				self.currentMap = ct
			}
		}
		for i in (0 ... 9).reversed() {
			let tnode: SmallMapNode = SmallMapNode.init(size: CGSize.init(width: 240, height: 135), type: 10 - i)
			tnode.position = CGPoint.init(x: 0, y: 150 + i * 170)
			tnode.zPosition = 1
			node.addChild(tnode)
			smallMaps.append(tnode)
			if i == 9 {
				tnode.addChild(selectedNode)
			}
		}

		return node
	}()
	
	lazy var backNode: ButtonNode = {
		let node = ButtonNode.init(texture: TextureAtlasManager.shared.uiAtlas?.textureNamed("left1"), color: UIColor.clear, size: CGSize.init(width: 95, height: 100))
		node.selectedTexture = TextureAtlasManager.shared.uiAtlas?.textureNamed("left2")
		node.zPosition = 2
		node.anchorPoint = CGPoint.init(x: 0, y: 1)
		node.position = CGPoint.init(x: 10, y: self.size.height - 10)
		node.clickAction = { (node) in
			self.backAction?()
		}
		return node
	}()
	
	lazy var startNode: ButtonNode = {
		let node = ButtonNode.init(texture: SKTexture.init(imageNamed: "start1"), color: UIColor.clear, size: CGSize.init(width: 168, height: 90))
		node.selectedTexture = SKTexture.init(imageNamed: "start")
		node.zPosition = 2
		node.anchorPoint = CGPoint.init(x: 0.5, y: 0)
		node.position = CGPoint.init(x: 650, y: 20)
		node.clickAction = { (node) in
			self.startGame?(self.currentMap)
		}
		return node
	}()
	
	override init(size: CGSize) {
		super.init(size: size)
		addChild(bgNode1)
		addChild(bgNode)
		addChild(previewNode)
		addChild(scrollNode)
		addChild(backNode)
		addChild(startNode)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

class SmallMapNode: SKSpriteNode {
	
	private(set) var mapConfig: MapConfig
	
	private(set) var type: Int
	
	init(size: CGSize, type: Int) {
		self.type = type
		self.mapConfig = MapConfig.init(type: type)
		super.init(texture: SKTexture.init(imageNamed: mapConfig.mapSmallName), color: UIColor.clear, size: size)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
