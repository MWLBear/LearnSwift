//
//  GameSounds.swift
//  Cars
//
//  Created by Suresh Thotakura on 18/04/2020.
//  Copyright © 2020 Neharjun Technologies Limited. All rights reserved.
//

import SpriteKit

class GameSounds {
    
    static let sharedInstance = GameSounds()
    
    private init() {
        
    }
    
    let collectCoin = SKAction.playSoundFileNamed("collect", waitForCompletion: false)
    
    let switchLane = SKAction.playSoundFileNamed("Woosh", waitForCompletion: false)
    
    let crash = SKAction.playSoundFileNamed("crash", waitForCompletion: false)
}
