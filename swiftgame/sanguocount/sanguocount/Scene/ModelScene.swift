//
//  MoelScene.swift
//  sanguocount
//
//  Created by admin on 2021/10/13.
//

import Foundation
//
//  SelectScene.swift
//  sanguocount
//
//  Created by admin on 2021/10/11.
//

import UIKit
import SpriteKit

class ModelScene: SKScene {
    
    var playerName:String!
    init(size:CGSize,playerName:String) {
        self.playerName = playerName
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
     
        let background = Background(name: "bg1")
        addChild(background)
        
        let backNode = SKSpriteNode(imageNamed: "btnReturn")
        backNode.name = "back"
        backNode.position = convertPoint(toView: CGPoint(x: 40, y: 60))
        addChild(backNode)
        
        let normalNode = SKSpriteNode(imageNamed: "easy")
        normalNode.name = "easy"
        normalNode.position = convertPoint(toView: CGPoint(x: size.width/2, y: size.height/2 - 150))
        addChild(normalNode)
        
        let hardNode = SKSpriteNode(imageNamed: "hard")
        hardNode.name = "hard"
        hardNode.position = convertPoint(toView: CGPoint(x: size.width/2, y: size.height/2 ))
        addChild(hardNode)
        
        
        let endLessNode = SKSpriteNode(imageNamed: "endless")
        endLessNode.name = "endless"
        endLessNode.position = convertPoint(toView: CGPoint(x: size.width/2, y: size.height/2 + 150))
        addChild(endLessNode)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchlocation = touch.location(in: self)
        let node = self.atPoint(touchlocation)
        if(node.name == "back"){
            let scene = SelectScene(size: size) 
            self.view?.presentScene(scene, transition: .push(with: .right, duration: 0.5))
        }else if (node.name == "easy"){
            self.view?.presentScene(GameScene(size: size, playerName: playerName,ishard: false),transition: .doorsOpenHorizontal(withDuration: 0.5))
        }else if(node.name == "hard"){
            self.view?.presentScene(GameScene(size: size, playerName: playerName,ishard: true),transition: .doorsOpenHorizontal(withDuration: 0.5))
        }else if (node.name == "endless"){
            self.view?.presentScene(GameScene(size: size, playerName: playerName,ishard: false,endless: true),transition: .doorsOpenHorizontal(withDuration: 0.5))
        }
    }
}
