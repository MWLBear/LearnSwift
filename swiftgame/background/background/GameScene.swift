//
//  GameScene.swift
//  background
//
//  Created by admin on 2021/10/19.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
   /**
    理解:
    
    在SpriteKit坐标系中原点(0, 0)在左下角
    
    父控件的anchorPoint决定在父坐标系的中心点在哪里
    (0.5,0.5)表示原点在自身的中心点
    
    子控件的anchorPoint表示的是, position是以自身的某个位置为参考,
    以此来确定自身在父坐标系中位置
    
    */
    
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        createGrounds()
        addSprikit()
        print((self.scene?.size.width)!)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveGround()
    }
    
    func addSprikit(){
        let sk  = SKSpriteNode(imageNamed: "sk-1")
        sk.anchorPoint = CGPoint(x: 0.5, y: 0)
        sk.position = CGPoint(x: 100, y: -40)
        addChild(sk)
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
