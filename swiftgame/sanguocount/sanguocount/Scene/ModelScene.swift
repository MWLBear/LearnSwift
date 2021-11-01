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
        
        let modelsName = ["easy","hard","endless"]
        for (index,name) in modelsName.enumerated() {
            let position = CGPoint(x: self.frame.midX, y: size.height*0.65 - CGFloat( 150 * index))
            let player = SKSpriteNode(imageNamed: name)
            player.position = position
            player.name = name
            addChild(player)
        }
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
