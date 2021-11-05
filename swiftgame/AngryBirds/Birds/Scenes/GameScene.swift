//
//  GameScene.swift
//  Birds
//
//  Created by Roman Yakovliev on 16.10.2021.
//

import SpriteKit
import GameplayKit

enum RoundState {
    case ready, flying, finished, animating
}

class GameScene: SKScene {
    
    var SceneManagerDelegate: SceneManagerDelegate?
    
    var mapNode = SKTileMapNode()
    
    let gameCamera = GameCamera()
    var panRecognizer = UIPanGestureRecognizer()
    var pichRecognizer = UIPinchGestureRecognizer()
    var maxScale: CGFloat = 0
    
    var bird = Bird(type: .red)
    var birds = [
        Bird(type: .red),
        Bird(type: .blue),
        Bird(type: .yellow)
    ]
    var anchor = SKNode()
    
    var roundState = RoundState.ready
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        setupLevel()
        setupGestureRecognizers()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch roundState {
        case .ready:
            if let touch = touches.first {
                let location = touch.location(in: self)
                if bird.contains(location) {
                    panRecognizer.isEnabled = false
                    bird.grabbed = true
                    bird.position = location
                }
            }
        case .flying:
            break
        case .finished:
            guard let view = view else { return }
            roundState = .animating
            let moveCameraBackAction = SKAction.move(to: CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2), duration: 1.25)
            moveCameraBackAction.timingMode = .easeInEaseOut
            gameCamera.run(moveCameraBackAction) {
                self.panRecognizer.isEnabled = true
                self.addBird()
            }
        case .animating:
            break
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if bird.grabbed {
                let location = touch.location(in: self)
                bird.position = location
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bird.grabbed {
            gameCamera.setConstraints(with: self, and: mapNode.frame, to: bird)
            bird.grabbed = false
            bird.flying = true
            roundState = .flying
            constraintToAnchor(active: false)
            let dx = anchor.position.x - bird.position.x
            let dy = anchor.position.y - bird.position.y
            let impulse = CGVector(dx: dx*1.5, dy: dy*1.5)
            bird.physicsBody?.applyImpulse(impulse)
            bird.isUserInteractionEnabled = false
        }
    }
    
    func setupGestureRecognizers() {
        guard let view = view else { return }
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan))
        view.addGestureRecognizer(panRecognizer)
        
        pichRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        view.addGestureRecognizer(pichRecognizer)
    }
    
    func setupLevel() {
        if let mapNode = childNode(withName: "Tile Map Node") as? SKTileMapNode {
            self.mapNode = mapNode
            let mapSizeDelta = max(mapNode.mapSize.width, mapNode.mapSize.height)
            let frameSizeDelta = max(frame.size.width, frame.size.height)
//            maxScale = mapNode.mapSize.width/frame.size.width
            maxScale = mapSizeDelta/frameSizeDelta
        }
        
        addCamera()
        
        // Getting blocks from GameScene TileMap
        for child in mapNode.children {
            if let child = child as? SKSpriteNode {
                guard let name = child.name else { continue }
                if !["wood", "stone", "glass"].contains(name) { continue }
                guard let type = BlockType(rawValue: name) else { continue }
                let block = Block(type: type)
                block.size = child.size
                block.position = child.position
                block.zRotation = child.zRotation
                block.zPosition = ZPositions.obstacles
                block.physicsBody()
                mapNode.addChild(block)
                child.removeFromParent()
            }
        }
        
        let physicsRect = CGRect(x: 0, y: mapNode.tileSize.height, width: mapNode.frame.size.width, height: mapNode.frame.size.height - mapNode.tileSize.height)
        physicsBody = SKPhysicsBody(edgeLoopFrom: physicsRect)
        physicsBody?.categoryBitMask = PhysicsCategory.edge
        physicsBody?.contactTestBitMask = PhysicsCategory.bird | PhysicsCategory.block
        physicsBody?.collisionBitMask = PhysicsCategory.all
        
        anchor.position =  CGPoint(x: mapNode.frame.midX/2, y: mapNode.frame.midY/2)
        addChild(anchor)
        addBird()
    }
    
    func addCamera() {
        guard let view = view else { return }
        addChild(gameCamera)
        gameCamera.position = CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2)
        camera = gameCamera
        gameCamera.setConstraints(with: self, and: mapNode.frame, to: nil)
    }
    
    func addBird() {
        if birds.isEmpty {
            print("Done")
            return
        }
        bird = birds.removeFirst()
        bird.physicsBody = SKPhysicsBody(rectangleOf: bird.size)
        bird.physicsBody?.categoryBitMask = PhysicsCategory.bird
        bird.physicsBody?.contactTestBitMask = PhysicsCategory.all
        bird.physicsBody?.collisionBitMask = PhysicsCategory.block | PhysicsCategory.edge
        bird.physicsBody?.isDynamic = false
        bird.position = anchor.position
        addChild(bird)
        bird.aspectScale(to: mapNode.tileSize, width: false, multiplier: 1.0)
        constraintToAnchor(active: true)
        roundState = .ready
    }
    
    func constraintToAnchor(active: Bool) {
        if active {
            let slingRange = SKRange(lowerLimit: 0.0, upperLimit: bird.size.width*3)
            let positionConstraint = SKConstraint.distance(slingRange, to: anchor)
            bird.constraints = [positionConstraint]
        } else {
            bird.constraints?.removeAll()
        }
    }
    
    override func didSimulatePhysics() {
        guard let physicsBody = bird.physicsBody else { return }
        if roundState == .flying && physicsBody.isResting {
            gameCamera.setConstraints(with: self, and: mapNode.frame, to: nil)
            bird.removeFromParent()
            roundState = .finished
        }
    }
    
    
    
}


extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let mask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch mask {
        case PhysicsCategory.bird | PhysicsCategory.block,
            PhysicsCategory.block | PhysicsCategory.edge:
            if let block = contact.bodyB.node as? Block {
                block.impact(with: Int(contact.collisionImpulse))
            } else if let block = contact.bodyA.node as? Block {
                block.impact(with: Int(contact.collisionImpulse))
            }
            if let bird = contact.bodyA.node as? Bird {
                bird.flying = false
            } else if let bird = contact.bodyB.node as? Bird {
                bird.flying = false
            }
        case PhysicsCategory.block | PhysicsCategory.block:
            if let block = contact.bodyA.node as? Block {
                block.impact(with: Int(contact.collisionImpulse))
            }
            if let block = contact.bodyB.node as? Block {
                block.impact(with: Int(contact.collisionImpulse))
            }
        case PhysicsCategory.bird | PhysicsCategory.edge:
            bird.flying = false
        default:
            break
        }
    }
    
}


extension GameScene {
    
    @objc func pan(sender: UIPanGestureRecognizer) {
        guard let view = view else { return }
        let translation = sender.translation(in: view) * gameCamera.yScale
        gameCamera.position = CGPoint(x: gameCamera.position.x - translation.x, y: gameCamera.position.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        guard let view = view else { return }
        if sender.numberOfTouches == 2 {
            let locationInView = sender.location(in: view)
            let location = convertPoint(fromView: locationInView)
            
            if sender.state == .changed {
                let convertedScale = 1/sender.scale
                let newScale = gameCamera.yScale*convertedScale // yScale == xScale in this case
                
                if newScale < maxScale && newScale > 0.5 {
                    gameCamera.setScale(newScale)
                }
                
                let locationAfterScale = convertPoint(fromView: locationInView)
//                let locationDelta = CGPoint(x: location.x - locationAfterScale.x, y: location.y - locationAfterScale.y)
                let locationDelta = location - locationAfterScale
//                let newPosition = CGPoint(x: gameCamera.position.x + locationDelta.x, y: gameCamera.position.y + locationDelta.y)
                let newPosition = gameCamera.position + locationDelta
                gameCamera.position = newPosition
                sender.scale = 1.0
                gameCamera.setConstraints(with: self, and: mapNode.frame, to: nil)
            }
        }
    }
    
}
