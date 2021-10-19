//
//  GameScene.swift
//  sanguocount
//
//  Created by admin on 2021/10/12.
//

import SpriteKit

let π = CGFloat.pi

struct PhysicsCategory {
    static let None: UInt32 = 0
    static let yb: UInt32 = 1 // 1
    static let player: UInt32 = 2 // 2
    static let enemy: UInt32 = 4 // 4
}

class GameScene: SKScene {
    var playerName: String!
    var player: PlayerNode!
    let scoreLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
    let timerLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
    var currentLevel: Int = 0
    var score = 0 {
        didSet{
            scoreLabel.text = "score: \(score)"
        }
    }
    var isLose = false
    var timerCount: Int = 0 {
        didSet {
            timerLabel.text = "timer: \(timerCount)"
        }
    }
    var timer: Timer!
    var isHard: Bool!
    var isEndless:Bool!
    init(size: CGSize, playerName: String, ishard: Bool,endless:Bool = false) {
        super.init(size: size)
        self.playerName = playerName
        isHard = ishard
        isEndless = endless
        timerCount = endless ? 100000 : Int.random(in: 15 ... 25)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        addBg()
        addScoreLabel()
        startGame()
        LZAudio.sharedInstance().playBackgroundMusic("game1.mp3")
    }
    
    override func update(_ currentTime: TimeInterval) {
        enumerateChildNodes(withName: "yuanbao") { node, _ in
            if(node.position.y < -10){
                node.removeFromParent()
                self.lose()
            }
        }
    }
    
    func addBg(){
        let background = Background(name: "palybg1")
        addChild(background)

        let backNode = SKSpriteNode(imageNamed: "btnReturn")
        backNode.name = "back"
        backNode.position = convertPoint(toView: CGPoint(x: 40, y: 60))
        addChild(backNode)
    }
    
    func startGame() {
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run {
                    self.spawnNode("yuanbao", isenemy: false)
                },
                SKAction.wait(forDuration: 1.0),
                SKAction.run {
                    self.spawnNode("enemy", isenemy: true)
                },
                SKAction.wait(forDuration: 1.0),
            ])
        ), withKey: "show")
        addPlayer()
        startTimer()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(count), userInfo: nil, repeats: true)
    }

    func invaliTimer() {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
    
    @objc func count() {
        timerCount -= 1

        if timerCount < 4 {
            let scaleUp = SKAction.scale(by: 1.2, duration: 0.5)
            let scaleDown = scaleUp.reversed()
            let action = SKAction.sequence([scaleUp, scaleDown])
            timerLabel.run(action)
        }

        if timerCount == 0 {
            won()
        }
    }

    func addScoreLabel() {
        scoreLabel.fontSize = 30
        scoreLabel.position = convertPoint(toView: CGPoint(x: size.width - 100, y: 60))
        scoreLabel.text = "score: \(score)"
        addChild(scoreLabel)

        timerLabel.fontSize = isEndless ? 27 : 30
        timerLabel.fontColor = .red
        timerLabel.position = convertPoint(toView: CGPoint(x: size.width - 100, y: 100))
        timerLabel.text = "timer: \(timerCount)"
        addChild(timerLabel)
    }

    func spawnNode(_ name: String, isenemy: Bool) {
        let gameNode = EnemyNode(name: name, isenemy: isenemy)
        gameNode.position = CGPoint(x: CGFloat.random(in: gameNode.size.width / 2 ... size.width - gameNode.size.width / 2), y: size.height + gameNode.size.height / 2)
        addChild(gameNode)
        gameNode.spawnMovie(isHard: isHard)
    }

    func addPlayer() {
        player = PlayerNode(positionInit: CGPoint(x: 300, y: 200), showBg: false, atlasName: playerName)
        addChild(player)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        if node.name == "back" {
            self.backToSelectScene()
        } else if node.name == "btnHome" {
            view?.presentScene(LoadScene(size: size), transition: .push(with: .right, duration: 0.5))
        } else if node.name == "btnRefresh" {
            reSetGame()
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        if node.name == "back" {
            self.backToSelectScene()
        } else {
            player.position = location
        }
    }

    func backToSelectScene(){
        invaliTimer()
        showSelectScene()
    }
    func showSelectScene() {
        if !isLose {
            countScore()
        }
        let scene = ModelScene(size: size, playerName: playerName)
        view?.presentScene(scene, transition: .push(with: .right, duration: 0.5))
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let yuanbao = contact.bodyA.categoryBitMask == PhysicsCategory.player ? contact.bodyB : contact.bodyA
        if yuanbao.categoryBitMask == PhysicsCategory.yb {
            addscore(yuanbao.node!)
        } else {
            lose()
        }
    }

    func addscore(_ yb: SKNode) {
        LZAudio.sharedInstance().playSoundEffect("yuanbao.mp3")
        score += 1
        let scaleUp = SKAction.scale(by: 2.5, duration: 0.1)
        let scaleDown = scaleUp.reversed()
        let removeFromParent = SKAction.removeFromParent()
        let actions = [scaleUp, scaleDown, removeFromParent]
        yb.run(SKAction.sequence(actions))
    }

    func removePlayer() {
        player.remove()
    }

    func lose() {
        isLose = true
        LZAudio.sharedInstance().pauseBackgroundMusic()
        LZAudio.sharedInstance().playSoundEffect("lose.mp3")
        commonHandleGame()
        showResultNode(name: "lose")
    }

    func won() {
        LZAudio.sharedInstance().pauseBackgroundMusic()
        LZAudio.sharedInstance().playSoundEffect("won.mp3")
        commonHandleGame()
        if !isLose {
            showResultNode(name: "win")
        }
    }
    
    func commonHandleGame(){
        invaliTimer()
        countScore()
        removeNode()
    }
    
    func showResultNode(name:String){
        let node = ResultNode(
            positionInit: CGPoint(x: size.width / 2, y: size.height + 300),
            score: score,
            textureName: name)
        addChild(node)
        removeAction(forKey: "show")
    }
    
    func removeNode() {
        removePlayer()
        enumerateChildNodes(withName: "ResultNode") { node, _ in
            node.removeFromParent()
        }
        enumerateChildNodes(withName: "yuanbao") { node, _ in
            node.removeFromParent()
        }
        enumerateChildNodes(withName: "enemy*") { node, _ in
            node.removeFromParent()
        }
    }

    func reSetGame() {
        LZAudio.sharedInstance().resumeBackgroundMusic()
        removeNode()
        score = 0
        isLose = false
        timerCount = isEndless ? 100000 : Int.random(in: 15 ... 25)
        startGame()
    }
    
    func countScore() {
        if score > UserScoreDefault.getBestSocre() {
            UserScoreDefault.setBestScore(score: score)
        }
    }
}
