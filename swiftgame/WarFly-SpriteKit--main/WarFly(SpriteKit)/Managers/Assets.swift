//
//  Assets.swift
//  WarFly(SpriteKit)
//
//  Created by Oleg Kanatov on 13.10.21.
//

import SpriteKit

class Assets {
    static let shared = Assets()
    var isLoaded = false
    let yellowAmmoAtlas = SKTextureAtlas(named: "YellowAmmo")
    let bluePowerUpAtlas = SKTextureAtlas(named: "BluePowerUp")
    let enemy_1Atlas = SKTextureAtlas(named: "Enemy_1")
    let enemy_2Atlas = SKTextureAtlas(named: "Enemy_2")
    let greenPowerUpAtlas = SKTextureAtlas(named: "GreenPowerUp")
    let playerPlaneAtlas = SKTextureAtlas(named: "PlayerPlane")
    
    func preloadAssets() {
        yellowAmmoAtlas.preload { print("yellowAmmoAtlas preloaded") }
        bluePowerUpAtlas.preload { print("bluePowerUpAtlas preloaded") }
        enemy_1Atlas.preload { print("enemy_1Atlas preloaded") }
        enemy_2Atlas.preload { print("enemy_2Atlas preloaded") }
        greenPowerUpAtlas.preload { print("greenPowerUpAtlas preloaded") }
        playerPlaneAtlas.preload { print("playerPlaneAtlas preloaded") }
    }
}
