//
//  ScrollNode.swift
//  SKTool
//
//  Created by songnaiyin on 2018/9/5.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import SpriteKit

open class ScrollNode: SKSpriteNode {

	public var touchAction: ((CGPoint) -> Void)?
	
	public var contentSize: CGSize = CGSize.zero {
		didSet {
			contentNode.size = CGSize.init(width: self.size.width, height: contentSize.height > self.size.height ? contentSize.height : self.size.height)
			let offset = contentOffset
			contentOffset = offset
		}
	}
	
	public var contentOffset: CGPoint = CGPoint.zero {
		didSet {
			contentNode.position = contentOffset
			fixContentNodeFrame()
		}
	}
	
	lazy var contentNode: SKSpriteNode = {
		let node = SKSpriteNode.init(texture: nil, color: UIColor.clear, size: self.size)
		node.isUserInteractionEnabled = false
		node.anchorPoint = CGPoint.init(x: 0.5, y: 0)
		return node
	}()
	
	lazy var cropNode: SKCropNode = {
		let node = SKCropNode.init()
		let maskNode = SKSpriteNode.init(texture: nil, color: UIColor.white, size: self.size)
		maskNode.anchorPoint = CGPoint.init(x: 0.5, y: 0)
		node.maskNode = maskNode
		node.addChild(contentNode)
		node.isUserInteractionEnabled = false
		return node
	}()
	
	override open func addChild(_ node: SKNode) {
		if node == contentNode || node == cropNode {
			super.addChild(node)
		} else {
			contentNode.addChild(node)
		}
	}
	
	override public init(texture: SKTexture?, color: UIColor, size: CGSize) {
		super.init(texture: texture, color: color, size: size)
		self.anchorPoint = CGPoint.init(x: 0.5, y: 0)
		addChild(cropNode)
		self.isUserInteractionEnabled = true
	}
	
	private var lastTouch: UITouch?
	private var lastLocation: CGPoint = CGPoint.zero
	private var isClick: Bool = false
	open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			isClick = true
			lastLocation = touch.location(in: self)
		}
	}
	
	open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			isClick = false
			lastTouch = touch
			let point = touch.location(in: self)
			contentNode.position = CGPoint.init(x: contentNode.position.x, y: contentNode.position.y + (point.y - lastLocation.y))
			lastLocation = point
		}
	}
	
	open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		fixContentNodeFrame()
		if let touch = touches.first {
			let point = touch.location(in: contentNode)
			if isClick {
				touchAction?(point)
			}
		}
	}
	
	open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		fixContentNodeFrame()
	}

	func fixContentNodeFrame() {
		if contentNode.frame.minY > 0 {
			contentNode.run(SKAction.moveTo(y: 0, duration: 0.3))
		}
		if contentNode.frame.maxY < self.size.height {
			contentNode.run(SKAction.moveTo(y: -(self.contentSize.height - self.size.height), duration: 0.3))
		}
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

