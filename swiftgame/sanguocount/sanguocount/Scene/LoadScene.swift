//
//  GameScene.swift
//  sanguocount
//
//  Created by admin on 2021/10/11.
//

import SpriteKit

class LoadScene: SKScene {
    
    let startlogoAction: SKAction
    var homelogtextures:[SKTexture] = []
    let infobtn = SKSpriteNode(imageNamed: "btnInfo")
    var infoContent:SKSpriteNode!
                                   
    override init(size: CGSize) {
        let startatlas = SKTextureAtlas(named: "startlogo")
        for i in 1...startatlas.textureNames.count {
            homelogtextures.append(startatlas.textureNamed("startlogo_\(i).png"))
        }
        startlogoAction = SKAction.animate(with: homelogtextures, timePerFrame: 0.1)
        super.init(size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        addbackground()
       // gamePlay()
    }
    
    func gamePlay(){
       
    }
    func addbackground() {
        LZAudio.sharedInstance().playBackgroundMusic("Login.wav")
     
        let background = Background(name: "bg1")
        addChild(background)
        
        let scoreLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
        scoreLabel.position = convertPoint(toView: CGPoint(x: 80, y: 60))
        scoreLabel.fontSize = 30
        scoreLabel.text = "High: \(UserScoreDefault.getBestSocre())"
        addChild(scoreLabel)
        
        let startLogo = SKSpriteNode(texture: homelogtextures[0],size: CGSize(width: 250, height: 300))
        startLogo.run(SKAction.repeatForever(startlogoAction))
        startLogo.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        startLogo.position = CGPoint(x: size.width/2, y: size.height/2 + 120)
       // addChild(startLogo)
        
        infobtn.position = CGPoint(x: size.width-50, y: size.height-50)
        infobtn.name = "info"
        addChild(infobtn)
        
        infoContent = GuideNode(positionInit: CGPoint(x: size.width + 300, y: size.height/2))
        infoContent.name = "infoContent"
        infoContent.zPosition = 3
        addChild(infoContent)
        
        let startBtn = SKSpriteNode(texture: SKTexture(imageNamed: "start"), size: CGSize(width: 150, height: 50))
        startBtn.name = "start"
        startBtn.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(startBtn)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let node = self.atPoint(touchLocation)
        if(node.name == "start"){
            LZAudio.sharedInstance().playSoundEffect("click.mp3")
            let scene = SelectScene(size: size) 
            self.view?.presentScene(scene, transition: .doorsOpenHorizontal(withDuration: 0.5))
        }else if (node.name == "info"){
            infoContent.run(SKAction.moveTo(x: size.width/2, duration: 0.5))
        }else if(node.name == "infoContent"){
            infoContent.run(SKAction.moveTo(x: size.width + 300, duration: 0.5))
        }
    }
}
