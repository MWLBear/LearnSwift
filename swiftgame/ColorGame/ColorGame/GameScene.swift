//
//  GameScene.swift
//  ColorGame
//
//  Created by Kas Song on 12/15/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // MARK: - Properties
    var tracksArray: [SKSpriteNode]? = [SKSpriteNode]()
    var player: SKSpriteNode?
    var target: SKSpriteNode?
    
    // HUD
    var pause: SKSpriteNode?
    var timeLabel: SKLabelNode?
    var scoreLabel: SKLabelNode?
    var currentScore: Int = 0 {
        didSet {
            scoreLabel?.text = "SCORE: \(currentScore)"
            GameHandler.shared.score = currentScore
        }
    }
    var remainingTime: TimeInterval = 60 {
        didSet {
            timeLabel?.text = "TIME: \(Int(remainingTime))"
        }
    }
    
    var currentTrack = 0
    var movingToTrack = false
    
    let moveSound = SKAction.playSoundFileNamed("move.wav", waitForCompletion: false)
    var backgroundNoise: SKAudioNode!
    
    let trackVelocities = [180, 200, 250]
    var directionArray = [Bool]()
    var velocityArray = [Int]()
    
    let playerCategory: UInt32 = 0x1 << 0
    let enemyCategory: UInt32 = 0x1 << 1
    let targetCategory: UInt32 = 0x1 << 2
    let powerUpCategory: UInt32 = 0x1 << 3
    
    // MARK: - Lifecycle
    override func didMove(to view: SKView) {
        setupTracks()
        createHUD()
        launchGameTimer()
        createPlayer()
        createTarget()
        physicsWorld.contactDelegate = self
        if let musicURL = Bundle.main.url(forResource: "background", withExtension: "wav") {
            backgroundNoise = SKAudioNode(url: musicURL)
            addChild(backgroundNoise)
        }
        
        if let numberOfTracks = tracksArray?.count {
            for _ in 0...numberOfTracks {
                let randomNumberForVelocity = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
                velocityArray.append(trackVelocities[randomNumberForVelocity])
                directionArray.append(GKRandomSource.sharedRandom().nextBool())
            }
        }
        run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run { self.spawnEnemies() },
            SKAction.wait(forDuration: 2)
        ])))
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let player = player {
            if player.position.y > size.height || player.position.y < 0 {
                movePlayerToStart()
            }
        }
        if remainingTime <= 5 {
            timeLabel?.fontColor = UIColor.red
        }
        
        if remainingTime == 0 {
            gameOver()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.previousLocation(in: self)
            let node = nodes(at: location).first
            
            if node?.name == "right" {
                if currentTrack < 8 {
                    moveToNextTrack()
                }
            } else if node?.name == "up" {
                moveVertically(up: true)
            } else if node?.name == "down" {
                moveVertically(up: false)
            } else if node?.name == "pause", let scene = scene {
                if scene.isPaused {
                    scene.isPaused = false
                } else {
                    scene.isPaused = true
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !movingToTrack {
            player?.removeAllActions()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        player?.removeAllActions()
    }
    
    // MARK: - Helpers
    func createPlayer() {
        player = SKSpriteNode(imageNamed: "player")
        player?.physicsBody = SKPhysicsBody(circleOfRadius: player!.size.width / 2)
        player?.physicsBody?.linearDamping = 0
        player?.physicsBody?.categoryBitMask = playerCategory
        player?.physicsBody?.collisionBitMask = 0
        player?.physicsBody?.contactTestBitMask = enemyCategory | targetCategory | powerUpCategory
        
        guard let playerPosition = tracksArray?.first?.position.x else { return }
        player?.position = CGPoint(x: playerPosition, y: size.height / 2)
        addChild(player!)
        
        let pulse = SKEmitterNode(fileNamed: "pulse")!
        player?.addChild(pulse)
        pulse.position = CGPoint(x: 0, y: 0)
    }
    
    func createTarget() {
        target = childNode(withName: "target") as? SKSpriteNode
        target?.physicsBody = SKPhysicsBody(circleOfRadius: target!.size.width / 2)
        target?.physicsBody?.categoryBitMask = targetCategory
        target?.physicsBody?.collisionBitMask = 0
    }
    
    func createEnemy(type: Enemies, forTrack track: Int) -> SKShapeNode? {
        let enemySprite = SKShapeNode()
        enemySprite.name = "ENEMY"
        switch type {
        case .small:
            enemySprite.path = CGPath(roundedRect: CGRect(x: -10, y: 0, width: 20, height: 70),
                                      cornerWidth: 8,
                                      cornerHeight: 8,
                                      transform: nil)
            enemySprite.fillColor = UIColor(red: 0.4431, green: 0.5529, blue: 0.7451, alpha: 1)
        case .meduim:
            enemySprite.path = CGPath(roundedRect: CGRect(x: -10, y: 0, width: 20, height: 100),
                                      cornerWidth: 8,
                                      cornerHeight: 8,
                                      transform: nil)
            enemySprite.fillColor = UIColor(red: 0.7804, green: 0.4039, blue: 0.4039, alpha: 1)
        case .large:
            enemySprite.path = CGPath(roundedRect: CGRect(x: -10, y: 0, width: 20, height: 130),
                                      cornerWidth: 8,
                                      cornerHeight: 8,
                                      transform: nil)
            enemySprite.fillColor = UIColor(red: 0.7804, green: 0.6392, blue: 0.4039, alpha: 1)
        }
        guard let enemyPosition = tracksArray?[track].position else { return nil }
        let up = directionArray[track]
        enemySprite.position.x = enemyPosition.x
        enemySprite.position.y = up ? -130 : size.height + 130
        enemySprite.physicsBody = SKPhysicsBody(edgeLoopFrom: enemySprite.path!)
        enemySprite.physicsBody?.categoryBitMask = enemyCategory
        enemySprite.physicsBody?.velocity = up ? CGVector(dx: 0, dy: velocityArray[track]) : CGVector(dx: 0, dy: -velocityArray[track])
        return enemySprite
    }
    
    func spawnEnemies() {
        var randomTrackNumber = 0
        let createPowerUp = GKRandomSource.sharedRandom().nextBool()
        
        if createPowerUp {
            randomTrackNumber = GKRandomSource.sharedRandom().nextInt(upperBound: 6) + 1
            if let powerUpObject = self.createPowerUp(forTrack: randomTrackNumber) {
                addChild(powerUpObject)
            }
        }
        
        for i in 1...7 {
            if randomTrackNumber != i {
                let randomEnemyType = Enemies(rawValue: GKRandomSource.sharedRandom().nextInt(upperBound: 3))!
                if let newEnemy = createEnemy(type: randomEnemyType, forTrack: i) {
                    addChild(newEnemy)
                }
            }
        }
        enumerateChildNodes(withName: "ENEMY",
                            using: { node, _ in
            if node.position.y < -150 || node.position.y > self.size.height + 150 {
                node.removeFromParent()
            }
        })
    }
    
    func setupTracks() {
        for i in 0...8 {
            if let track = childNode(withName: "\(i)") as? SKSpriteNode {
                tracksArray?.append(track)
            }
        }
    }
    
    func moveVertically(up: Bool) {
        if up {
            let moveAction = SKAction.moveBy(x: 0, y: 3, duration: 0.01)
            let repeatAction = SKAction.repeatForever(moveAction)
            player?.run(repeatAction)
        } else {
            let moveAction = SKAction.moveBy(x: 0, y: -3, duration: 0.01)
            let repeatAction = SKAction.repeatForever(moveAction)
            player?.run(repeatAction)
        }
    }
    
    func moveToNextTrack() {
        player?.removeAllActions()
        movingToTrack = true
        
        guard let nextTrack = tracksArray?[currentTrack + 1].position else { return }
        if let player = player {
            let moveAction = SKAction.move(to: CGPoint(x: nextTrack.x, y: player.position.y), duration: 0.2)
            let up = directionArray[currentTrack + 1]
            player.run(moveAction, completion: {
                self.movingToTrack = false
                if self.currentTrack != 8 {
                    self.player?.physicsBody?.velocity = up
                    ? CGVector(dx: 0, dy: self.velocityArray[self.currentTrack])
                    : CGVector(dx: 0, dy: -self.velocityArray[self.currentTrack])
                } else {
                    self.player?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                }
                
            })
            currentTrack += 1
            run(moveSound)
        }
    }
    
    func movePlayerToStart() {
        if let player = player {
            player.removeFromParent()
            self.player = nil
            createPlayer()
            currentTrack = 0
        }
    }
    
    func nextLevel(playerPhysicsBody: SKPhysicsBody) {
        currentScore += 1
        run(SKAction.playSoundFileNamed("levelUp.wav", waitForCompletion: true))
        let emitter = SKEmitterNode(fileNamed: "fireworks.sks")!
        playerPhysicsBody.node?.addChild(emitter)
        run(SKAction.wait(forDuration: 0.5),
            completion: {
            emitter.removeFromParent()
            self.movePlayerToStart()
        })
    }
    
    func createHUD() {
        pause = childNode(withName: "pause") as? SKSpriteNode
        timeLabel = childNode(withName: "time") as? SKLabelNode
        scoreLabel = childNode(withName: "score") as? SKLabelNode
        remainingTime = 60
        currentScore = 0
    }
    
    func launchGameTimer() {
        let timeAction = SKAction.repeatForever(
            SKAction.sequence(
                [SKAction.run { self.remainingTime -= 1},
                 SKAction.wait(forDuration: 1)]
            )
        )
        timeLabel?.run(timeAction)
    }
    
    func createPowerUp(forTrack track: Int) -> SKSpriteNode? {
        let powerUpSprite = SKSpriteNode(imageNamed: "powerUp")
        powerUpSprite.name = "ENEMY"
        powerUpSprite.physicsBody = SKPhysicsBody(circleOfRadius: powerUpSprite.size.width / 2)
        powerUpSprite.physicsBody?.linearDamping = 0
        powerUpSprite.physicsBody?.categoryBitMask = powerUpCategory
        powerUpSprite.physicsBody?.collisionBitMask = 0
        
        let up = directionArray[track]
        guard let powerUpXPosition = tracksArray?[track].position.x else { return nil }
        powerUpSprite.position.x = powerUpXPosition
        powerUpSprite.position.y = up ? -130 : size.height + 130
        powerUpSprite.physicsBody?.velocity = up ? CGVector(dx: 0, dy: velocityArray[track]) : CGVector(dx: 0, dy: -velocityArray[track])
        return powerUpSprite
    }
    
    func gameOver() {
        GameHandler.shared.saveGameStats()
        run(SKAction.playSoundFileNamed("levelCompleted.wav", waitForCompletion: true))
        let transition = SKTransition.fade(withDuration: 1)
        if let gameOverScene = SKScene(fileNamed: "GameOverScene") {
            gameOverScene.scaleMode = .aspectFit
            view?.presentScene(gameOverScene, transition: transition)
        }
    }
}

// MARK: - SKPhysicsContactDelegate
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        var playerBody: SKPhysicsBody
        var otherBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            playerBody = contact.bodyA
            otherBody = contact.bodyB
        } else {
            playerBody = contact.bodyB
            otherBody = contact.bodyA
        }
        
        if playerBody.categoryBitMask == playerCategory && otherBody.categoryBitMask == enemyCategory {
            run(SKAction.playSoundFileNamed("fail.wav", waitForCompletion: true))
            movePlayerToStart()
        } else if playerBody.categoryBitMask == playerCategory && otherBody.categoryBitMask == targetCategory {
            nextLevel(playerPhysicsBody: playerBody)
        } else if playerBody.categoryBitMask == playerCategory && otherBody.categoryBitMask == powerUpCategory {
            run(SKAction.playSoundFileNamed("powerUp.wav", waitForCompletion: true))
            otherBody.node?.removeFromParent()
            remainingTime += 5
        }
    }
}
