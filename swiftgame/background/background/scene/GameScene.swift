//
//  GameScene.swift
//  background
//
//  Created by admin on 2021/10/19.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    private var player: AVPlayer!
    private var video: SKVideoNode!
    
    var arrowPath: CGPath = {
      let bezierPath = UIBezierPath()
      
      bezierPath.move(to: CGPoint(x: 0.5, y: 65.69))
      bezierPath.addLine(to: CGPoint(x: 74.99, y: 1.5))
      bezierPath.addLine(to: CGPoint(x: 74.99, y: 38.66))
      bezierPath.addLine(to: CGPoint(x: 257.5, y: 38.66))
      bezierPath.addLine(to: CGPoint(x: 257.5, y: 92.72))
      bezierPath.addLine(to: CGPoint(x: 74.99, y: 92.72))
      bezierPath.addLine(to: CGPoint(x: 74.99, y: 126.5))
      bezierPath.addLine(to: CGPoint(x: 0.5, y: 65.69))
      bezierPath.close()
      
      return bezierPath.cgPath
    }()
    
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        createGrounds()
        addSprikit()
        print((self.scene?.size.width)!)
        addSKcrop()
        addplayer()
        addSKShapeNode()
    }
    
    func addSKcrop(){
        let masknode1 = SKLabelNode(fontNamed: "AvenirNext-Regular")
        masknode1.text = "SKCropNode"
        
        let masknode2 = SKSpriteNode(imageNamed: "select_frame-hd")
        
        let bg = SKSpriteNode(imageNamed: "background1")
        let skcrop = SKCropNode()
        skcrop.position = CGPoint(x: -200, y: 80)
        skcrop.addChild(bg)
        skcrop.maskNode = masknode1
        addChild(skcrop)
    }
    
    func addplayer(){
        let fileUrl = Bundle.main.url(forResource: "discolights-loop", withExtension: "mov")!
        player = AVPlayer(url: fileUrl)
        video = SKVideoNode(avPlayer: player)
        video.size = self.size
        video.position = CGPoint(x: 0, y: 0)
        video.zPosition = -2
        addChild(video)
        video.play()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReachEndOfVideo), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    @objc func didReachEndOfVideo(){
        print("rewind")
        player.currentItem!.seek(to: CMTime.zero) { _ in
            self.player.play()
        }
    }
    
    func addSKShapeNode(){
        let shape = SKShapeNode(path: arrowPath)
        shape.setScale(0.5)
        shape.strokeColor = SKColor.gray
        shape.lineWidth = 4
        shape.fillColor = SKColor.white
        addChild(shape)
        
        shape.fillTexture = SKTexture(imageNamed: "wood_tinted")
        shape.alpha = 0.5
        let move = SKAction.moveBy(x: -40, y: 0, duration: 1.0)
        let bounce = SKAction.sequence([
            move,move.reversed()
        ])
        let buonceAction = SKAction.repeat(bounce, count: 4)
        shape.run(buonceAction) {
            shape.removeFromParent()
        }
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        moveGround()
    }
    
    func addSprikit(){
        let sk  = SKSpriteNode(imageNamed: "sk-1")
        sk.anchorPoint = CGPoint(x: 0.5, y: 0)
        sk.position = CGPoint(x: 100, y: -40)
        //addChild(sk)
        
        let playButton = SKSpriteButton(defaultButtonImage: "playButton", action: goToLevelScene)
        playButton.position = CGPoint(x: -100, y: frame.midY)
        playButton.setScale(0.2)
        addChild(playButton)
    }
    func goToLevelScene(_: Int) {
        let scene = SKScene(fileNamed: "LevelScene") as? LevelScene
        scene?.touchAction = { level in
            print("等级:\(level)")
        }
        self.view?.presentScene(scene)
    }
    
    func createGrounds(){
        for i in 0...3 {
            let ground = SKSpriteNode(imageNamed: "gr")
            ground.name = "Ground"
            ground.size = CGSize(width: self.frame.size.width, height: 160)
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            ground.position = CGPoint(x: CGFloat(i)*ground.size.width, y: -(self.size.height / 2 ) + 50)
            addChild(ground)
        }
    }
    
    func moveGround(){
        enumerateChildNodes(withName: "Ground") { noode, _ in
            noode.position.x -= 2
            if noode.position.x < -((self.scene?.size.width)!){
                noode.position.x += (self.scene?.size.width)! * 3
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view?.presentScene(ScrollScene(size: self.size))
    }
}
