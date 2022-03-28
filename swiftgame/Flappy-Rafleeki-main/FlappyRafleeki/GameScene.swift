//
//  GameScene.swift
//  FlappyRafleeki
//
//  Created by Drew Bayles on 9/2/21.
//

import SpriteKit
import GameplayKit
import AVFoundation

struct PhysicsCategory {
    static let Character : UInt32 = 0x1 << 1
    static let Ground : UInt32 = 0x1 << 2
    static let Wall : UInt32 = 0x1 << 3
    static let Score : UInt32 = 0x1 << 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var ground : SKSpriteNode?
    private var sky : SKSpriteNode?
    private var character : SKSpriteNode?
    private var wallPair = SKNode()
    private var moveAndRemove = SKAction()
    private var gameStarted = Bool()
    private var died = Bool()
    private var score = Int()
    private var restartBtn = SKLabelNode()
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var scoreLabel : SKLabelNode?
    
    private var deathSound = SKAction.playSoundFileNamed("death-sound.mp3", waitForCompletion: false)
    private var tapSound = SKAction.playSoundFileNamed("vine-boom.mp3", waitForCompletion: false)

    let deathSoundURL = Bundle.main.url(forResource: "death-sound", withExtension: "mp3")
    
    func restartScene() {
        let gameScene = GameScene(fileNamed: "GameScene")
        let transition = SKTransition.fade(withDuration: 1.0)
        gameScene?.scaleMode = .aspectFill
        self.view?.presentScene(gameScene!, transition: transition)
    }
    
    // When the scene is presented. Initial setup.
    override func sceneDidLoad() {
        self.physicsWorld.contactDelegate = self
        
        // Setup the score label
        self.scoreLabel = self.childNode(withName: "//scoreLabel") as? SKLabelNode
        if let scoreLabel = self.scoreLabel {
            //scoreLabel.position = CGPoint(x: 0, y: 0 + self.frame.height / 4)
            scoreLabel.text = "\(score)"
            scoreLabel.zPosition = 5
            //scoreLabel.fontSize = 200
        }
        
        // Setup the sky
        self.sky = self.childNode(withName: "//sky") as? SKSpriteNode
        
        // Setup the ground
        self.ground = self.childNode(withName: "//ground") as? SKSpriteNode
        if let ground = self.ground {
            //Ground.setScale(3.0)
            //Ground.position = CGPoint(x: 0, y: -self.frame.height/2 + Ground.frame.height / 2)
            
            //ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width, height: ground.size.height * 2.0))
            ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
            ground.physicsBody?.categoryBitMask = PhysicsCategory.Ground
            ground.physicsBody?.collisionBitMask = PhysicsCategory.Character
            ground.physicsBody?.contactTestBitMask = PhysicsCategory.Character
            ground.physicsBody?.affectedByGravity = false
            ground.physicsBody?.isDynamic = false
            
            //Ground.zPosition = 3
        }
        
        // Setup the character
        self.character = self.childNode(withName: "//character") as? SKSpriteNode
        if let character = self.character {
            //character = SKSpriteNode(imageNamed: "Raphael_1")
            //character.size = CGSize(width: 300, height: 300)
            //character.position = CGPoint(x: 0, y: 0)
            
            //character.physicsBody = SKPhysicsBody(circleOfRadius: Raphael.frame.height / 2)
            character.physicsBody?.categoryBitMask = PhysicsCategory.Character
            character.physicsBody?.collisionBitMask = PhysicsCategory.Ground | PhysicsCategory.Wall
            character.physicsBody?.contactTestBitMask = PhysicsCategory.Ground | PhysicsCategory.Wall | PhysicsCategory.Score
            //character.physicsBody?.affectedByGravity = false
            //character.physicsBody?.isDynamic = true
            
            //character.zPosition = 2
        }
        
        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }

    }
    
    func createWalls() {
        
        let scoreNode = SKSpriteNode()

        scoreNode.size = CGSize(width: 1, height: self.frame.height)
        scoreNode.position = CGPoint(x: self.frame.width, y: 0)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.isDynamic = false
        scoreNode.physicsBody?.categoryBitMask = PhysicsCategory.Score
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.physicsBody?.contactTestBitMask = PhysicsCategory.Character
        //scoreNode.color = .orange
        
        wallPair = SKNode()
        
        let topWall = SKSpriteNode(imageNamed: "wall-building")
        let btmWall = SKSpriteNode(imageNamed: "wall-building")
        
        topWall.position = CGPoint(x: self.frame.width, y: 1500)
        btmWall.position = CGPoint(x: self.frame.width, y: -1500)
        
        topWall.zRotation = CGFloat(Double.pi)
        
        topWall.setScale(2.0)
        btmWall.setScale(2.0)
        
        // Getting the texture is an expensive task and causes a slight lag
        //topWall.physicsBody = SKPhysicsBody(texture: SKTexture.init(imageNamed: "Wall"), alphaThreshold: 0, size: topWall.size)
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        topWall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        topWall.physicsBody?.collisionBitMask = PhysicsCategory.Character
        topWall.physicsBody?.contactTestBitMask = PhysicsCategory.Character
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.affectedByGravity = false
        topWall.physicsBody?.friction = 0
        topWall.physicsBody?.restitution = 0
        topWall.physicsBody?.angularDamping = 0
        topWall.physicsBody?.angularVelocity = 0

        // Getting the texture is an expensive task and causes a slight lag
        //btmWall.physicsBody = SKPhysicsBody(texture: SKTexture.init(imageNamed: "Wall"), alphaThreshold: 0, size: btmWall.size)
        btmWall.physicsBody = SKPhysicsBody(rectangleOf: btmWall.size)
        btmWall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        btmWall.physicsBody?.collisionBitMask = PhysicsCategory.Character
        btmWall.physicsBody?.contactTestBitMask = PhysicsCategory.Character
        btmWall.physicsBody?.isDynamic = false
        btmWall.physicsBody?.affectedByGravity = false
        btmWall.physicsBody?.friction = 0
        btmWall.physicsBody?.restitution = 0
        btmWall.physicsBody?.angularDamping = 0
        btmWall.physicsBody?.angularVelocity = 0

        
        wallPair.addChild(topWall)
        wallPair.addChild(btmWall)
        
        wallPair.zPosition = 1
        
        let randomNumber = CGFloat(arc4random_uniform(1300)) - 650
        wallPair.position.y = wallPair.position.y + randomNumber
        
        wallPair.addChild(scoreNode)
        
        wallPair.run(moveAndRemove)
        
        self.addChild(wallPair)
    
    }
    
    func createBtn() {
        //restartBtn = SKSpriteNode(color: SKColor.blue, size: CGSize(width: 400, height: 200))
        restartBtn = SKLabelNode(text: "Reset")
        restartBtn.position = CGPoint(x: 0, y: 0)
        restartBtn.zPosition = 5
        restartBtn.fontSize = 200
        self.addChild(restartBtn)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if firstBody.categoryBitMask == PhysicsCategory.Score && secondBody.categoryBitMask == PhysicsCategory.Character ||
            firstBody.categoryBitMask == PhysicsCategory.Character && secondBody.categoryBitMask == PhysicsCategory.Score {
            if let node = contact.bodyB.node as? SKSpriteNode {
                if node.parent != nil {
                    node.removeFromParent()
                    score += 1
                }
            }
            if let scoreLabel = self.scoreLabel {
                scoreLabel.text = "\(score)"
            }
        }
        
        if firstBody.categoryBitMask == PhysicsCategory.Wall && secondBody.categoryBitMask == PhysicsCategory.Character ||
            firstBody.categoryBitMask == PhysicsCategory.Character && secondBody.categoryBitMask == PhysicsCategory.Wall ||
            firstBody.categoryBitMask == PhysicsCategory.Ground && secondBody.categoryBitMask == PhysicsCategory.Character ||
            firstBody.categoryBitMask == PhysicsCategory.Character && secondBody.categoryBitMask == PhysicsCategory.Ground {
           // self.run(deathSound)
//            let audioSession = AVAudioSession.sharedInstance()
//            do {
//                try audioSession.setCategory(.ambient, mode: .default, options: [])
//            } catch {
//                print("Failed to set audio session category")
//            }
//
//            do {
//                try AVAudioSession.sharedInstance().setActive(true)
//            } catch {
//                print("helo billy")
//            }
//
//            let player = try AVAudioPlayer(contentsOf: deathSoundURL)
//            player.play()
//
            //AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient, error: nil)
            //AVAudioSession.sharedInstance().setActive(true, error: nil)
            
            
            died = true
            //self.isPaused = true
            createBtn()
        }
        

        
    }
    
    // Tells this object that one or more new touches occurred in a view or window.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "FadeOut")!, withKey: "fadeOut")
        }

        // This makes the "Reset" button work when clicked
        for t in touches {
            let location = t.location(in: self)
            if died == true {
                if restartBtn.contains(location) { restartScene() }
            }
        }
        
        if gameStarted == false {
            
            gameStarted = true
            
            if let character = self.character {
                character.physicsBody?.affectedByGravity = true
                character.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                character.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 6000))
            }
            
            self.run(tapSound)
            
            let spawnWalls = SKAction.run({
                () in
                
                self.createWalls()
            })
            
            let delay = SKAction.wait(forDuration: 1.3)
            let spawnDelay = SKAction.sequence([spawnWalls, delay])
            let spawnDelayForever = SKAction.repeatForever(spawnDelay)
            self.run(spawnDelayForever)
            
            let distance = CGFloat(self.frame.width*2)
            print(distance)
            let movePipes = SKAction.moveBy(x: -distance, y: 0, duration: TimeInterval(0.0016 * distance))
            let removePipes = SKAction.removeFromParent()
            moveAndRemove = SKAction.sequence([movePipes, removePipes])
            
            if let ground = self.ground {
                let moveLeft = SKAction.moveBy(x: -self.size.width, y: 0, duration: TimeInterval(0.002 * ground.size.width * 2.0))
                let moveReset = SKAction.moveBy(x: self.size.width, y: 0, duration: 0)
                let moveForever = SKAction.repeatForever(SKAction.sequence([moveLeft, moveReset]))
                ground.run(moveForever)
            }
            
            if let sky = self.sky {
                let moveLeft = SKAction.moveBy(x: -self.size.width, y: 0, duration: TimeInterval(0.004 * sky.size.width * 2.0))
                let moveReset = SKAction.moveBy(x: self.size.width, y: 0, duration: 0)
                let moveForever = SKAction.repeatForever(SKAction.sequence([moveLeft, moveReset]))
                sky.run(moveForever)
            }
            
        }
        else {
            
            if died == true {
                self.run(deathSound)
            }
            else {
                if let Raphael = self.character {
                    Raphael.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    Raphael.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 4000))
                }
                self.run(tapSound)
            }
        }
        
    }
    
    // Tells your app to perform any app-specific logic to update your scene.
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
