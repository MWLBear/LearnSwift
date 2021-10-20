//
//  GameScene.swift
//  JuegoTemasSelectos
//
//  Created by CEDAM 25 on 11/26/19.
//  Copyright © 2019 UNAM. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate  {
    
    var background = SKSpriteNode()
    var jugador : SKSpriteNode!
    var enemigos = ["enemy1","enemy2", "enemy3"]
    var gameTimer : Timer!
    var arregloVidas : [SKSpriteNode]!
    //score
    var scoreLabel : SKLabelNode!
    var score:Int = 0 {
        didSet{
            scoreLabel.text = "Score \(score)"
        }
    }
    //Categorías de los nodos
    let enemyBalaCategory:UInt32 = 0x1 << 3
    let jugadorCategory:UInt32 = 0x1 << 2
    let enemyCategory:UInt32 = 0x1 << 1
    let balaCategory:UInt32 = 0x1 << 0
    
    override func didMove(to view: SKView) {
        createBackground()
        vidas()
        
        jugador = SKSpriteNode(imageNamed: "player")
        jugador.size = CGSize(width: 120, height: 120)
        jugador.position = CGPoint(x: size.width/2, y: 150)
        jugador.zRotation = .pi/2
        jugador.zPosition = 2
        
        jugador.physicsBody = SKPhysicsBody(rectangleOf: jugador.size)
        jugador.physicsBody?.isDynamic = true
        jugador.physicsBody?.categoryBitMask = jugadorCategory
        jugador.physicsBody?.contactTestBitMask = enemyBalaCategory
        jugador.physicsBody?.contactTestBitMask = enemyCategory
        jugador.physicsBody?.collisionBitMask = 0
        jugador.physicsBody?.usesPreciseCollisionDetection = true
        addChild(jugador)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(añadirEnemigos), userInfo: nil, repeats: true)
        gameTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(disparoJugador), userInfo: nil, repeats: true)
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 160, y: self.frame.height - 90)
        scoreLabel.zPosition = 10
        scoreLabel.fontSize = 70
        addChild(scoreLabel)
       
        
    }
    
    
    //Creación de vidas
    func vidas(){
        arregloVidas = [SKSpriteNode]()
        
        for vida in 1...3{
            let vidaNodo = SKSpriteNode(imageNamed: "player")
            vidaNodo.zPosition = 9
            vidaNodo.zRotation = .pi/2
            vidaNodo.size = CGSize(width: 100, height: 100)
            vidaNodo.position = CGPoint(x: self.frame.size.width - CGFloat(4 - vida) *  vidaNodo.size.width, y: self.frame.size.height - 80)
            addChild(vidaNodo)
            arregloVidas.append(vidaNodo)
        }
        
    }
    
    
    //Creación de enemigos
    @objc func añadirEnemigos() {
        
        enemigos = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: enemigos) as! [String]
        let  avionEnemigo = SKSpriteNode(imageNamed: enemigos[0])
        let posicionEnenmigo = GKRandomDistribution(lowestValue: 150, highestValue: 550)
        let posicion = CGFloat(posicionEnenmigo.nextInt())
        
        avionEnemigo.position = CGPoint(x: posicion, y: size.height)
        addChild(avionEnemigo)
        avionEnemigo.size = CGSize(width: 120, height: 120)
        avionEnemigo.zRotation = -.pi/2
        
        
        avionEnemigo.physicsBody = SKPhysicsBody(rectangleOf: avionEnemigo.size)
        avionEnemigo.physicsBody?.isDynamic = true
        avionEnemigo.physicsBody?.categoryBitMask = enemyCategory
        //avionEnemigo.physicsBody?.contactTestBitMask = enemyBalaCategory
        avionEnemigo.physicsBody?.collisionBitMask = 0
        avionEnemigo.physicsBody?.usesPreciseCollisionDetection = true
        
        
        //Disparo
        
        let balaEnemigo = SKSpriteNode(imageNamed: "bullet2")
        balaEnemigo.position = avionEnemigo.position
        balaEnemigo.size = CGSize(width: 25, height: 35)
        balaEnemigo.zRotation = .pi
        balaEnemigo.zPosition = 1
        
        
        addChild(balaEnemigo)
        balaEnemigo.physicsBody = SKPhysicsBody(circleOfRadius: balaEnemigo.size.width)
        balaEnemigo.physicsBody?.isDynamic = true
        balaEnemigo.physicsBody?.categoryBitMask = enemyBalaCategory
        balaEnemigo.physicsBody?.contactTestBitMask = jugadorCategory
        balaEnemigo.physicsBody?.collisionBitMask = 0
        balaEnemigo.physicsBody?.usesPreciseCollisionDetection = true
        
        
        var arregloAccionesBala = [SKAction]()
        
        arregloAccionesBala.append(SKAction.move(to: CGPoint(x: avionEnemigo.position.x, y: -size.height), duration: 3))
        arregloAccionesBala.append(SKAction.removeFromParent())
        balaEnemigo.run(SKAction.sequence(arregloAccionesBala))
        
        
        
        
        
        var arregloAcciones = [SKAction]()
        
        arregloAcciones.append(SKAction.move(to: CGPoint(x: posicion, y: -size.height + 1200), duration: 6))
        arregloAcciones.append(SKAction.run {
                   
                   if self.arregloVidas.count > 0 {
                       let vidaNodo = self.arregloVidas.first
                       vidaNodo!.removeFromParent()
                       self.arregloVidas.removeFirst()
                       
                       if self.arregloVidas.count == 0 {
                           //Gameover
                        let transicion = SKTransition.flipHorizontal(withDuration: 0.5)
                        let gameOver = GameOverScene(size: self.size)
                        gameOver.score = self.score
                        self.view?.presentScene(gameOver,transition: transicion)
                        
                       }
                   }
                   
               })
        arregloAcciones.append(SKAction.removeFromParent())
       
        avionEnemigo.run(SKAction.sequence(arregloAcciones))
        
    }
    
    //Disparo del jugador
    @objc func disparoJugador() {
        
        let bala = SKSpriteNode(imageNamed: "bullet1")
        bala.position = jugador.position
        bala.size = CGSize(width: 25, height: 35)
        
        addChild(bala)
        bala.physicsBody = SKPhysicsBody(circleOfRadius: bala.size.width)
        bala.physicsBody?.isDynamic = true
        bala.physicsBody?.categoryBitMask = balaCategory
        bala.physicsBody?.contactTestBitMask = enemyCategory
        bala.physicsBody?.collisionBitMask = 0
        bala.physicsBody?.usesPreciseCollisionDetection = true
        
        
        var arregloAcciones = [SKAction]()
        arregloAcciones.append(SKAction.playSoundFileNamed("Disparo", waitForCompletion: false))
        arregloAcciones.append(SKAction.move(to: CGPoint(x: jugador.position.x, y: size.height), duration: 0.6))
        
        arregloAcciones.append(SKAction.removeFromParent())
        
        bala.run(SKAction.sequence(arregloAcciones))
    }
        
    
    @objc func disparoEnemigo(Enemigo:SKSpriteNode){
        //Balas enemigos
        
        let balaEnemigo = SKSpriteNode(imageNamed: "bullet2")
        balaEnemigo.position = Enemigo.position
        
        balaEnemigo.zPosition = 1
        
        
        addChild(balaEnemigo)
        balaEnemigo.physicsBody = SKPhysicsBody(circleOfRadius: balaEnemigo.size.width)
        balaEnemigo.physicsBody?.isDynamic = true
        balaEnemigo.physicsBody?.categoryBitMask = enemyBalaCategory
        balaEnemigo.physicsBody?.contactTestBitMask = jugadorCategory
        balaEnemigo.physicsBody?.collisionBitMask = 0
        balaEnemigo.physicsBody?.usesPreciseCollisionDetection = true
        
        
        var arregloAccionesBala = [SKAction]()
        
        arregloAccionesBala.append(SKAction.move(to: CGPoint(x: Enemigo.position.x, y: -size.height), duration: 5))
        arregloAccionesBala.append(SKAction.removeFromParent())
        balaEnemigo.run(SKAction.sequence(arregloAccionesBala))
    }
    
    //Colisiones
    func colisionEnemigo (balaNodo:SKSpriteNode, enemyNodo:SKSpriteNode){
        
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = enemyNodo.position
        explosion.zPosition = 3
        addChild(explosion)
        balaNodo.removeFromParent()
        enemyNodo.removeFromParent()
        
        score += 5
    }
    
    func colisionPlayer (balaNodo:SKSpriteNode, playerNodo:SKSpriteNode){
          
          let explosion = SKEmitterNode(fileNamed: "Explosion")!
          explosion.position = playerNodo.position
          explosion.zPosition = 3
          addChild(explosion)
          balaNodo.removeFromParent()
          
          if self.arregloVidas.count > 0 {
              let vidaNodo = self.arregloVidas.first
              vidaNodo!.removeFromParent()
              self.arregloVidas.removeFirst()
              
              if self.arregloVidas.count == 0 {
                  //Gameover
                let transicion = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameOver = GameOverScene(size: size)
                gameOver.score = self.score
                self.view?.presentScene(gameOver,transition: transicion)
              }
          }
          
      }
    
    func colisionAviones (jugadorNodo:SKSpriteNode, enemyNodo:SKSpriteNode){
        
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = jugadorNodo.position
        explosion.zPosition = 3
        addChild(explosion)
        enemyNodo.removeFromParent()
        
        if self.arregloVidas.count > 0 {
                              let vidaNodo = self.arregloVidas.first
                              vidaNodo!.removeFromParent()
                              self.arregloVidas.removeFirst()
                              
                              if self.arregloVidas.count == 0 {
                                  //Gameover
                                let transicion = SKTransition.flipHorizontal(withDuration: 0.5)
                                let gameOver = GameOverScene(size: size)
                                gameOver.score = self.score
                                self.view?.presentScene(gameOver,transition: transicion)
                              }
                          }
        
    }
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var primerCuerpo:SKPhysicsBody
        var segundoCuerpo:SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            primerCuerpo = contact.bodyA
            segundoCuerpo = contact.bodyB
        }else{
            primerCuerpo = contact.bodyB
            segundoCuerpo = contact.bodyA
        }
        
        if(primerCuerpo.categoryBitMask & balaCategory) != 0 && (segundoCuerpo.categoryBitMask & enemyCategory) != 0 {
            colisionEnemigo(balaNodo: primerCuerpo.node as! SKSpriteNode, enemyNodo: segundoCuerpo.node as! SKSpriteNode)
        }
        
        if(primerCuerpo.categoryBitMask & enemyCategory) != 0 && (segundoCuerpo.categoryBitMask & jugadorCategory) != 0 {
            colisionAviones(jugadorNodo: segundoCuerpo.node as! SKSpriteNode, enemyNodo: primerCuerpo.node as! SKSpriteNode)
        }
        
        if(primerCuerpo.categoryBitMask & jugadorCategory) != 0 && (segundoCuerpo.categoryBitMask & enemyBalaCategory) != 0 {
            colisionPlayer(balaNodo: segundoCuerpo.node as! SKSpriteNode, playerNodo: primerCuerpo.node as! SKSpriteNode)
        }
        
        
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            jugador.position = location
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        moverFondo()
    }
    
    func createBackground(){
        for i in 0...3 {
            
            let background = SKSpriteNode(imageNamed: "Background")
            background.name = "Fondo"
            background.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
            background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            background.position = CGPoint(x: self.frame.size.width/2, y: CGFloat(i) * background.size.height)
            background.zPosition = -1
            self.addChild(background)
            
        }
    }
    
    func moverFondo(){
        self.enumerateChildNodes(withName: "Fondo") { (node, error) in
            node.position.y -= 20
            if node.position.y < -((self.scene?.size.height)!) {
                node.position.y += (self.scene?.size.height)! * 3
            }
        }
        
    }
    
    
}
