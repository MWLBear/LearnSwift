//
//  GameOverScene.swift
//  JuegoTemasSelectos
//
//  Created by CEDAM 25 on 11/26/19.
//  Copyright © 2019 UNAM. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    
    var score : Int = 0
    var background = SKSpriteNode()
    
 
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "Inicio")
        background.name = "Fondo"
        background.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        background.zPosition = -1
        self.addChild(background)
        
        let finJuego = SKLabelNode(text: "GAME OVER")
        finJuego.fontSize = 120
        finJuego.name = "fin"
        finJuego.fontName = "Herculanum"
        
        let scoreLabel = SKLabelNode(text: "Score: \(score)")
        scoreLabel.fontSize = 90
        scoreLabel.fontName = "Herculanum"
        
        
        
        let nuevoJuego = SKLabelNode(text: "Play Again")
        nuevoJuego.fontSize = 80
        nuevoJuego.name = "juega"
        nuevoJuego.fontName = "Herculanum"
        
        
        addChild(finJuego)
        addChild(scoreLabel)
        addChild(nuevoJuego)
        nuevoJuego.position = CGPoint(x: size.width/2, y: size.height/2 - 200)
        finJuego.position = CGPoint(x: size.width/2, y: size.height/2 + 200)
        scoreLabel.position = CGPoint(x: size.width/2, y: size.height/2)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // crear un guard para verificar el evento (si se toca la pantalla con el primer toque
            guard let toque = touches.first else {
                return
            }
            // obtener la localización del toque
            let locacionToque = toque.location(in: self)
            // el nodo fue tocado
            let toqueNodo = self.atPoint(locacionToque)
            // si toca genera la nueva escena
            if(toqueNodo.name == "juega"){
                // size: size que sea del mismo tamaño
                let nueva = GameScene(size: size)
                nueva.scaleMode = scaleMode
                // transisción
                let trans = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                view?.presentScene(nueva,transition: trans)
            }
        }
    

}
