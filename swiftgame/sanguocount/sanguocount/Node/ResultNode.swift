//
//  LoseNode.swift
//  sanguocount
//
//  Created by admin on 2021/10/12.
//

import SpriteKit

class ResultNode: SKSpriteNode {
    
    
    init(positionInit:CGPoint,score:Int,textureName:String) {
        
        let texture = SKTexture(imageNamed: textureName)
        super.init(texture: texture,color: .black,size: texture.size())
        name = "ResultNode"
        zPosition = 2
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        position = positionInit
        run(SKAction.moveTo(y: UIScreen.main.bounds.size.height/2, duration: 0.5))
        let labelColor = textureName == "win" ? UIColor.red :  UIColor.darkGray
        let scoreLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
        scoreLabel.text = "score: \(score)"
        scoreLabel.fontColor = labelColor
        scoreLabel.fontSize = 28
        scoreLabel.zPosition = 2
        scoreLabel.position = CGPoint(x: 0, y: -27)
        addChild(scoreLabel)
        
        let best = UserScoreDefault.getBestSocre()
        let bestScoreLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
        bestScoreLabel.text = "bestScore: \(best)"
        bestScoreLabel.fontColor = labelColor
        bestScoreLabel.fontSize = 28
        bestScoreLabel.zPosition = 2
        bestScoreLabel.position = CGPoint(x: 0, y: -65)
        addChild(bestScoreLabel)
        
        let btnRefresh = SKSpriteNode(imageNamed: "btnRefresh")
        btnRefresh.name = "btnRefresh"
        btnRefresh.zPosition = 2
        btnRefresh.position = CGPoint(x: -50, y: -95)
        addChild(btnRefresh)
        
        let homeNode = SKSpriteNode(imageNamed: "btnHome")
        homeNode.name = "btnHome"
        homeNode.zPosition = 2
        homeNode.position = CGPoint(x: 50, y: -95)

        addChild(homeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
