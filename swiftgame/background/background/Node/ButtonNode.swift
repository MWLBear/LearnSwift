//
//  ButtonNode.swift
//  background
//
//  Created by admin on 2021/11/1.
//

import SpriteKit

class ButtonNode: SKSpriteNode {
    
    public var clickAction:((ButtonNode)->Void)?
    
    override var normalTexture: SKTexture?{
        didSet {
            self.texture = normalTexture
        }
    }
    
    public var selectedTexture: SKTexture?{
        didSet {
            if isSelected {
                self.texture = selectedTexture
            }
        }
    }
    
    public var isSelected: Bool = false {
        didSet {
            _isSelected = isSelected
        }
    }
    
    private var _isSelected: Bool = false {
        didSet {
            if let st = selectedTexture, _isSelected {
                self.texture = st
            }else {
                self.texture = normalTexture
            }
        }
    }
    
    public var audioEnable: Bool = true
    
    private lazy var playAudioNode: SKAudioNode = {
       let node = SKAudioNode(fileNamed: "play.mp3")
        node.isPositional = true
        node.autoplayLooped = false
        return node
    }()
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.normalTexture = texture
        isUserInteractionEnabled = true
        addChild(playAudioNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(!isSelected){
            _isSelected = true
        }
        if audioEnable {
            playAudioNode.run(SKAction.play())
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            if CGRect(x: -self.size.width*self.anchorPoint.x, y: -self.size.height*self.anchorPoint.y, width: self.size.width, height: self.size.height).contains(point){
                clickAction?(self)
            }
        }
        if(!isSelected){
            _isSelected = false
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(!isSelected){
            _isSelected = false
        }
    }
}
