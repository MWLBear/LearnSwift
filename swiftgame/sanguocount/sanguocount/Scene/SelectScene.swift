//
//  SelectScene.swift
//  sanguocount
//
//  Created by admin on 2021/10/11.
//

import UIKit
import SpriteKit

class SelectScene: SKScene {
    
    var player1:SKSpriteNode!
    var player2:SKSpriteNode!
    var player3:SKSpriteNode!

    override func didMove(to view: SKView) {
        
        let background = Background(name: "bg1")
        addChild(background)
        
        let backhome = SKSpriteNode(imageNamed: "btnReturn")
        backhome.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backhome.position = CGPoint(x: 40, y: size.height-40)
        backhome.name = "backhome"
        addChild(backhome)
        
        
        let headerButton = ButtonNode(titled: "SELECT ROLE", backgroundName: "selectOpen")
        headerButton.position =  CGPoint(x: size.width/2, y: backhome.frame.midY - 65)
        addChild(headerButton)
        
        let HeightContant = 200
        let atlasName = ["player", "pao"]
        for (index,name) in atlasName.enumerated() {
            let position = CGPoint(x: self.frame.midX, y: size.height*0.65 - CGFloat( HeightContant * index))
            let player = PlayerNode(positionInit: position, showBg: true, atlasName: name)
            player.name = name
            addChild(player)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchlocation = touch.location(in: self)
        let node = self.atPoint(touchlocation)
        if(node.name == "backhome"){
            self.view?.presentScene(LoadScene(size: size),transition: .push(with: .right, duration: 0.5))
        }else if (node.name == "player"){
            LZAudio.sharedInstance().playSoundEffect("click.mp3")
            self.view?.presentScene(ModelScene(size: size,playerName: "player"),transition: .doorsOpenHorizontal(withDuration: 0.5))
        }else if(node.name == "pao"){
            LZAudio.sharedInstance().playSoundEffect("click.mp3")
            self.view?.presentScene(ModelScene(size: size,playerName: "pao"),transition: .doorsOpenHorizontal(withDuration: 0.5))
        }else if(node.name == "startlogo"){
            LZAudio.sharedInstance().playSoundEffect("click.mp3")
            self.view?.presentScene(ModelScene(size: size,playerName: "startlogo"),transition: .doorsOpenHorizontal(withDuration: 0.5))
        }
    }
}
