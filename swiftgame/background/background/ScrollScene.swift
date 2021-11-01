//
//  ScrollScene.swift
//  background
//
//  Created by admin on 2021/10/26.
//

import UIKit
import SpriteKit

class ScrollScene: SKScene {
    
    var smallMaps: [SelectNode] = [SelectNode]()
    
    
    lazy var selectedNode: SKSpriteNode = {
        let node = SKSpriteNode.init(texture: SKTexture.init(imageNamed: "select_frame-hd"), size: CGSize.init(width: 200, height: 135))
        node.zPosition = 2
        return node
    }()
    
    var currentSelect:SelectNode = SelectNode(size: CGSize(width: 200, height: 150), type: 1) {
        didSet {
            showNode.texture = SKTexture(imageNamed: "ss-\(currentSelect.type)")
            selectedNode.removeFromParent()
            let node = smallMaps[currentSelect.type-1]
            node.addChild(selectedNode)
        }
    }
    
    var bgNode:SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "bg")
        node.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        node.zPosition = -1
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        return node
    }()
    
    var showNode:SKSpriteNode = {
        let node = SKSpriteNode(texture: SKTexture(imageNamed: "ss-1"), size: CGSize(width: 300, height: 180))
        node.anchorPoint = CGPoint(x: 1, y: 0.5)
        node.position = CGPoint(x: 30, y: 0)
        return node
    }()
    
    lazy var scrollNode: ScrollNode = {
        let node = ScrollNode.init(texture: nil, color: .clear, size: CGSize.init(width: 200, height: 400))
        node.zPosition = 1
        node.position = CGPoint.init(x: 150, y: -200)
        node.contentSize = CGSize.init(width: 200, height: 1810)
        node.contentOffset = CGPoint.init(x: 0, y: -1810 + 400)
        node.touchAction = { (point) in
            var node:SelectNode?
            for tempNode in self.smallMaps {
                if tempNode.frame.contains(point) {
                    node = tempNode
                    break
                }
            }
            if let ct = node {
                self.currentSelect = ct
            }
        }
        for i in (0 ... 9).reversed() {
            let tnode = SelectNode(size: CGSize(width: 180, height: 150), type: (10-i))
            tnode.position = CGPoint.init(x: 0, y: 150 + i * 170)
            tnode.zPosition = 2
            node.addChild(tnode)
            smallMaps.append(tnode)
            if(i == 9){
                tnode.addChild(selectedNode)
            }
        }
        return node
    }()
    
    lazy var startNode: ButtonNode = {
        let node = ButtonNode.init(texture: SKTexture(imageNamed: "start1"), color: .clear, size: CGSize(width: 168, height: 90))
        node.selectedTexture = SKTexture.init(imageNamed: "start")
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.zPosition = 2
        node.position = CGPoint.init(x: 350, y: 20)
        node.clickAction = {node in
            print("开始游戏")
        }
        return node
    }()
    
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFit
        addChild(bgNode)
        addChild(scrollNode)
        addChild(showNode)
        addChild(startNode)
    }
}

class SelectNode:SKSpriteNode {
    var type:Int
    init(size:CGSize,type: Int){
        self.type = type
        super.init(texture: SKTexture(imageNamed: "ss-\(type)"), color: .clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
