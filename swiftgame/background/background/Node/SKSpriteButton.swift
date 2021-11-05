//
//  SKSpriteButton.swift
//  background
//
//  Created by admin on 2021/11/5.
//

import SpriteKit

class SKSpriteButton: SKSpriteNode {
    var defaultButton: SKSpriteNode
    var action: (Int)->(Void)
    var index: Int 
    
    init(defaultButtonImage:String,action:@escaping (Int)->(Void),index:Int = 0) {
        defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
        self.action = action
        self.index = index
        super.init(texture: nil, color: .clear, size: defaultButton.size)
        
        isUserInteractionEnabled = true
        addChild(defaultButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        defaultButton.alpha = 0.75
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let loctaion = touch.location(in: self)
        if defaultButton.contains(loctaion){
            defaultButton.alpha = 0.75
        }else {
            defaultButton.alpha = 1.0
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let loctaion = touch.location(in: self)
        if defaultButton.contains(loctaion){
            action(index)
        }
        defaultButton.alpha = 1.0
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        defaultButton.alpha = 1.0
    }
}
