//
//  GameScene.swift
//  Cars
//
//  Created by Suresh Thotakura on 12/04/2020.
//  Copyright © 2020 Neharjun Technologies Limited. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    let scoreLabel = SKLabelNode(text: "0")
    let gameSounds = GameSounds.sharedInstance

    var player: Car!
    var gameState = SceneState.notStarted
    
    var rowHeight: CGFloat = 0
    var laneWidth: CGFloat = 0
    
    var laneSpeeds = [CGFloat]()
    
    var frames : Int = 0 {
        didSet {
            timeSpent = frames / 60
        }
    }
    var score : Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    var timeSpent: Int = 0 {
        didSet {
            score = timeSpent + coinsCollected
        }
    }
    var coinsCollected: Int = 0 {
        didSet {
            score = timeSpent + coinsCollected
        }
    }
    
    var traffic = [Int: Set<TrafficCar>]()
    var roads = [Road]()
    
    var swipeLeftRecognizer : UISwipeGestureRecognizer?
    var swipeRightRecognizer : UISwipeGestureRecognizer?
    override func didMove(to view: SKView) {
        setUp()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if gameState != .started {
            return
        }
        
        updateScene()
        frames += 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameState == .notStarted {
            startScene()
            return
        }
    }
    
    func setUp() {
        setupScene()
        setupGestureRecognizers()
    }
    
    func setupScene() {
        laneWidth = (frame.size.width) / CGFloat(GameConfig.Lanes)
        
        laneSpeeds = [
            Helper.random(min: 1, max: 5),
            Helper.random(min: 1, max: 5),
            Helper.random(min: 1, max: 5),
            Helper.random(min: 1, max: 5)
        ]

        setupRoad()
        setupPlayer()
        setupTraffic()
        setupCoins()
        setupScoreLabel()
        setupPhysics()
    }
    
    func setupPhysics() {
        physicsWorld.contactDelegate = self
    }
    
    func setupPlayer(){
        player = Car(imageNamed: "blue-car", lane: 1)
        player.name = "player"
        player.position.x = getX(for: player.lane)
        player.position.y = 82

        addChild(player)
    }
    
    func setupRoad() {
        for i in 0...3 {
            let size = CGSize(width: frame.size.width, height: frame.size.height)
            let position = CGPoint(x: frame.minX, y:  CGFloat(i) * frame.size.height)
            let road = Road(size: size, position: position)

            roads.append(road)
            addChild(road)
        }
    }
    
    func setupTraffic() {
        rowHeight = Car.DefaultSize.height * 1.5
        
        for lane in 0..<GameConfig.Lanes {
            traffic[lane] = Set<TrafficCar>()
        }
        
        let maxY = frame.maxY + 2 * rowHeight
        
        for row in 0..<GameConfig.TrafficLayout.count {
            let rowMax = maxY - CGFloat(row) * rowHeight
            let rowMin = maxY - CGFloat(row + 1) * rowHeight
            
            for lane in 0..<GameConfig.Lanes {
                let laneSpeed = laneSpeeds[lane]
                if GameConfig.TrafficLayout[row][lane] == 1 {
                    let x = getX(for: lane)
                    var y = Helper.random(min: rowMin, max: rowMax)
                    if y - Car.DefaultSize.height < rowMin {
                        y = rowMin + Car.DefaultSize.height + CGFloat(15)
                    }

                    let trafficCar = TrafficCar(
                            imageNamed: Cars.names.randomElement()!,
                            row: row,
                            lane: lane,
                            position: CGPoint(x: x, y: y),
                            carSpeed: laneSpeed)
                    
                    addChild(trafficCar)
                    traffic[lane]?.insert(trafficCar)
                }
            }
        }
    }
    
    func setupCoins() {
        for row in 0..<GameConfig.CoinsLayout.count {
            for lane in 0..<GameConfig.Lanes {
                if GameConfig.CoinsLayout[row][lane] == 0 { continue }
                
                let currentLaneX = laneWidth * CGFloat(lane)
                let x = currentLaneX + (laneWidth - GameConfig.CoinSize.width) / 2 +  GameConfig.CoinSize.width / 2 + GameConfig.CoinSize.width / 8
                let y = frame.maxY - CGFloat(row) * Coin.DefaultSize.height * 1.2
                
                let coin = Coin(position: CGPoint(x: x, y: y ))

                addChild(coin)
            }
        }
    }
    
    func setupScoreLabel() {
        scoreLabel.fontSize = 50.0
        scoreLabel.fontName = GameConfig.BoldFontName
        scoreLabel.fontColor = UIColor.white
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY - frame.maxY / 8)
        scoreLabel.zPosition = ZPositions.score
        
        addChild(scoreLabel)
    }
    
    func startScene() {
        player.run(SKAction.moveTo(y: player.position.y + frame.size.height / 8, duration: 1.0))

        player.start()
        startTraffic()

        gameState = .started
    }
        
    func updateScene() {
        moveRoad()
        moveTraffic()
        moveCoins()
    }
    
    func moveRoad() {
        roads.forEach { road in
            road.move()
        }
    }
    
    func moveTraffic() {
        enumerateChildNodes(withName: "traffic", using:  { (node, _) in
            let car = node as! TrafficCar
            let laneTraffic = self.traffic[car.lane]!.sorted(by: { (carOne, carTwo) -> Bool in
                carOne.position.y > carTwo.position.y
            })
            car.move(laneTraffic: laneTraffic)
        })
    }
    
    func moveCoins() {
        enumerateChildNodes(withName: "coin", using: { (node, _) in
            let coin = node as! Coin
            coin.move()
        })
    }
    
    func getX(for lane: Int) -> CGFloat {
        CGFloat(lane) * laneWidth + Car.DefaultSize.width - (CGFloat(2 * CGFloat(lane)))
    }

    func stopTraffic() {
        enumerateChildNodes(withName: "traffic", using:  { (node, _) in
            let car = node as! TrafficCar
            car.stop()
        })
    }

    func startTraffic() {
        enumerateChildNodes(withName: "traffic", using:  { (node, _) in
            let car = node as! TrafficCar
            car.start()
        })
    }
        
    func stopScene(with trafficCar: TrafficCar, at point: CGPoint) {
        //gameState = .stopped

        player.crash()
        stopTraffic()

        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.categoryBitMask = PhysicsCategory.edge

        let impulse = Helper.calculateImpulse(first: player.position, second: trafficCar.position)
        trafficCar.physicsBody?.applyImpulse(impulse, at: point)
        
        persistScore()

        run(SKAction.wait(forDuration: 2), completion: {
            self.presentMenu()
        })
    }

    func persistScore() {
        UserDefaults.standard.set(score, forKey: "Score")
        if score > UserDefaults.standard.integer(forKey: "HighScore") {
            UserDefaults.standard.set(score, forKey: "HighScore")
        }
    }

    func presentMenu() {
        let menuScene = MenuScene(size: view!.bounds.size)
        view!.presentScene(menuScene, transition: SKTransition.fade(withDuration: 0.5))
    }

    func collectCoin(coin: Coin) {
        coin.collect()
        coinsCollected += coin.score
        score = timeSpent + coinsCollected
    }
}

extension GameScene : SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        if gameState != .started { return }
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == PhysicsCategory.player | PhysicsCategory.traffic {
            if let trafficCar = contact.bodyA.node?.name == "player" ? contact.bodyB.node as? TrafficCar : contact.bodyA.node as? TrafficCar {
                stopScene(with: trafficCar, at: contact.contactPoint)
            }
        }
        
        if contactMask == PhysicsCategory.player | PhysicsCategory.coin {
            if let coin = contact.bodyA.node?.name == "player" ? contact.bodyB.node as? Coin : contact.bodyA.node as? Coin {
                collectCoin(coin: coin)
            }
        }
    }
}

extension GameScene {
    
    func setupGestureRecognizers() {
        swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))

        swipeLeftRecognizer!.direction = .left
        swipeRightRecognizer!.direction = .right
        
        view!.addGestureRecognizer(swipeLeftRecognizer!)
        view!.addGestureRecognizer(swipeRightRecognizer!)
    }

    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if gameState != .started { return }
        
        var userCarLaneUpdated = false
        
        if sender.direction == .right && player.lane < 3 {
            player.lane += 1
            userCarLaneUpdated = true
        }
        
        if sender.direction == .left && player.lane > 0 {
            player.lane -= 1
            userCarLaneUpdated = true
        }
        
        if userCarLaneUpdated {
            player.run(SKAction.moveTo(x: getX(for: player.lane), duration: 0.25))
            run(gameSounds.switchLane)
        }
    }
}
