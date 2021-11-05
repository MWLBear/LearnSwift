//
//  MenuScene.swift
//  Cars
//
//  Created by Suresh Thotakura on 12/04/2020.
//  Copyright © 2020 Neharjun Technologies Limited. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    let labelColor = UIColor.white
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 0.6)
        
        addLogo()
        addLabels()
    }
    
    func addLogo(){
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.size = CGSize(width: frame.size.width / 4, height: frame.size.width * 1.7 / 4)
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height / 4)
        
        addChild(logo)
    }

    func addLabels() {
        let playLabel = SKLabelNode(text: "Tap to Play")
        playLabel.name = "playLabel"
        playLabel.fontName = GameConfig.BoldFontName
        playLabel.fontColor = labelColor
        playLabel.fontSize = 50.0
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playLabel)
        animate(label: playLabel)
        
        let scoreLabel = SKLabelNode(text: "Score: " + "\(UserDefaults.standard.integer(forKey: "Score"))")
        scoreLabel.fontName = GameConfig.BoldFontName
        scoreLabel.fontSize = 40.0
        scoreLabel.fontColor = labelColor
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - scoreLabel.frame.size.height*5)
        addChild(scoreLabel)

        let highScoreLabel = SKLabelNode(text: "High Score: " + "\(UserDefaults.standard.integer(forKey: "HighScore"))")
        highScoreLabel.fontName = GameConfig.BoldFontName
        highScoreLabel.fontSize = 40.0
        highScoreLabel.fontColor = labelColor
        highScoreLabel.position = CGPoint(x: frame.midX, y: scoreLabel.position.y - highScoreLabel.frame.size.height * 2)
        addChild(highScoreLabel)
    }
    
    func animate(label: SKLabelNode) {
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        let sequnce = SKAction.sequence([scaleUp, scaleDown])
        label.run(SKAction.repeatForever(sequnce))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        gameScene.scaleMode = .resizeFill
        view!.presentScene(gameScene, transition: SKTransition.fade(withDuration: 0.5))
    }

}
