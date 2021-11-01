//
//  ScrollNode.swift
//  background
//
//  Created by admin on 2021/10/26.
//

import UIKit
import SpriteKit
class ScrollNode: SKSpriteNode {
    
    public var touchAction:((CGPoint)->(Void))?
    
    public var contentSize: CGSize = CGSize.zero {
        didSet {
            contentNode.size = CGSize(width: self.size.width, height:  contentSize.height > self.size.height ? contentSize.height : self.size.height)
            let offset = contentOffset
            contentOffset = offset
        }
    }
    
    public var contentOffset:CGPoint = CGPoint.zero {
        didSet {
            contentNode.position = contentOffset
            fixContentNodeFrame()
        }
    }
    
    
    lazy var contentNode: SKSpriteNode = {
        let node = SKSpriteNode.init(texture: nil, color: .clear, size: self.size)
        node.isUserInteractionEnabled = false
        node.anchorPoint = CGPoint(x: 0.5, y: 0)
        return node
    }()
    
    lazy var cropNode:SKCropNode = {
        let node = SKCropNode.init()
        let maskNode = SKSpriteNode.init(texture: nil, color: .white, size: self.size)
        maskNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        node.maskNode = maskNode
        node.addChild(contentNode)
        node.isUserInteractionEnabled = false
        return node
    }()
    
    
    override func addChild(_ node: SKNode) {
        if node == contentNode || node == cropNode {
            super.addChild(node)
        }else {
            contentNode.addChild(node)
        }
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.anchorPoint = CGPoint.init(x: 0.5, y: 0)
        addChild(cropNode)
        self.isUserInteractionEnabled = true
    }
    
    private var lastTouch: UITouch?
    private var lastLocation: CGPoint = CGPoint.zero
    private var isClick: Bool = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            isClick = true
            lastLocation = touch.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            isClick = false
            lastTouch = touch
            let point = touch.location(in: self)
            contentNode.position = CGPoint(x: contentNode.position.x, y: contentNode.position.y + (point.y - lastLocation.y))
            lastLocation = point
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        fixContentNodeFrame()
        if let touch = touches.first {
            let point = touch.location(in: contentNode)
            if isClick {
                touchAction?(point)
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        fixContentNodeFrame()
    }
    
    func fixContentNodeFrame(){
        if(contentNode.frame.minY > 0){
            contentNode.run(SKAction.moveTo(y: 0, duration: 0.3))
        }
        
        if(contentNode.frame.maxY < self.size.height){
            contentNode.run(SKAction.moveTo(y: -(self.contentNode.size.height - self.size.height), duration: 0.3))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
