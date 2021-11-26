//
//  LevelScene.swift
//  background
//
//  Created by admin on 2021/11/5.
//

import SpriteKit

class LevelScene: SKScene {
    public var touchAction:((String)->(Void))?
    override func didMove(to view: SKView) {
        
    }
    func setupLevelSelection(){
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let loction = touch.location(in: self)
        let node = self.atPoint(loction)
        if node.isKind(of: SKLabelNode.self){
            guard let name = node.parent?.name else { return }
            touchAction?(name)
        }else {
            guard let name = node.name else { return }
            touchAction?(name)
            let size = CGSize(width: 2048, height: 1536)
            let scene = CrameScene(size: size)
            scene.scaleMode = .aspectFill
            self.view?.presentScene(scene)
        }
    }
}
