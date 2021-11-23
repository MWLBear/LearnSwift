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
    
    
    /**
     
     以下是物理体上其余属性的快速浏览：

     •friction：这设置了物体的“滑动性”。值从0.0（身体像冰块一样沿着表面平稳滑动）到1.0（身体沿着表面滑动时快速减速和停止不等。默认值为0.2。

     • isDynamic：有时您想使用物理体进行碰撞检测，但通过手动移动或操作自行移动节点。如果这是你想要的，只需将 isDynamic 设置为 false，物理引擎将忽略物理主体上的所有力量和脉冲，并允许您自己移动节点。

     •usesPreciseCollisionDetection：默认情况下，SpriteKit不执行精确的碰撞检测，因为通常最好牺牲一些精度来实现更快的性能。然而，这有一个副作用：如果一个物体像子弹一样移动得非常快，它可能会穿过另一个物体。如果发生这种情况，请尝试打开此标志，以便进行更准确的碰撞检测。

     •allowsRotation：您可能有一个精灵，您希望物理引擎模拟，但绝不旋转。如果是这样的话，只需将此标志设置为false。
     
     •线性偏振和角偏振：这些值会影响线性速度（翻译）或角速度（旋转）随时间下降的程度。值可以从速度从未下降的0.0到速度立即下降的1.0不等。默认值为0.1。

     • affectedByGravity：默认情况下，所有物体都受到重力的影响，但您只需将其设置为false即可关闭物体。

     •resting：物理引擎有一个优化，其中一段时间没有移动的对象被标记为“休息”，因此物理引擎不再需要对它们进行计算。如果您需要手动“唤醒”休息对象，只需将此标志设置为false。

     •质量和面积：这些是根据物理体的形状和密度自动为您计算的。然而，如果您需要手动覆盖质量，您可以。这个区域是只读的。

     •node：物理主体有一个方便的指针返回它所属的SKNode。这是一个只读属性。

     •categoryBitMask、collisionBitMask、contactTestBitMask和joins：您将在第9章“中级物理”和第10章“高级物理”中了解所有这些。
     
     
     */
    
    
    /**
     
     分类机构
     SpriteKit的默认行为是所有物理物体与所有其他物理物体碰撞。如果两个物体占据同一点，如砖头和猫床，物理引擎将自动将其中一个移到一边。
     1.定义类别：第一步是为您的物理身体定义类别，如块状体、猫体和猫床体。
     2.设置类别位掩码：一旦您拥有一组类别，您需要指定每个物理主体所属的类别，因为物理主体可以属于多个类别。您只需设置其类别位掩码即可做到这一点。
     3.设置碰撞位掩码：您还需要为每个物理体指定碰撞位掩码。这控制着身体将与哪些类别的身体碰撞。
     
     
     检测身体之间的contact
     您已经学会了使用categoryBitMask来设置物理体的类别，并使用collisionBitMask来设置物理体的碰撞类别。嗯，还有另一个位掩码：contactTestBitMask。
     您使用contactTestBitMask来定义当物理物体与另一个物体接触时，应该调用哪些类别的物体，从而调用物理联系人委托方法。
     很容易将collisionBitMask与contactTestBitMask混淆。请记住，碰撞是指物理模拟自动处理的内容（即当物体相互弹跳时），而接触仅指两个物体相互接触时。
     
     */
    
    
    
    /**
     
     作为第一个参数，您可以指定节点名称或搜索模式。如果您广泛使用XML，您将注意到相似之处：

     • /name：在层次结构的根目录中搜索名为“名称”的节点。

     • //name：搜索名为“名称”的节点，从根开始，递归移动

     等级森严。

     • *：匹配零个或更多字符；例如，名称*将匹配名称1、名称2、名称ABC和名称。

     enumerateChildNodes(withName:using:)返回一个数组，其中包含与您要查找的名称或模式匹配的所有节点，而childNode(withName:)则找到与给定名称或搜索模式匹配的第一个节点。
     
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
