//
//  StartScene.swift
//  ACGame
//
//  Created by Brian Advent on 30.05.17.
//  Copyright © 2017 Brian Advent. All rights reserved.
//

import SpriteKit

class StartScene: SKScene {
    
    var playButton: SKSpriteNode?
    var gameScene: SKScene!
    var backgroundMusic: SKAudioNode!
    
    var scrollingBG: ScrollingBackground?
    
    override func didMove(to view: SKView) {
        playButton = childNode(withName: "startButton") as? SKSpriteNode
        scrollingBG = ScrollingBackground.scrollingNodeWithImage(imageName: "loopBG", containerWidth: size.width)
        scrollingBG?.scrollingSpeed = 1.5
        scrollingBG?.anchorPoint = .zero
        addChild(scrollingBG!)
        
        if let musicURL = Bundle.main.url(forResource: "MenuHighscoreMusic", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let scrollingBG = scrollingBG else { return }
        scrollingBG.update(currentTime: currentTime)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = atPoint(pos)
            
            if node == playButton {
                let transition = SKTransition.fade(withDuration: 1)
                gameScene = SKScene(fileNamed: "GameScene")
                gameScene.scaleMode = .aspectFit
                view?.presentScene(gameScene, transition: transition)
            }
        }
    }
}
