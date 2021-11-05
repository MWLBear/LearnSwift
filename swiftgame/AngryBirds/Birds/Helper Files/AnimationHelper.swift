//
//  AnimationHelper.swift
//  Birds
//
//  Created by Roman Yakovliev on 19.10.2021.
//

import SpriteKit

class AnimationHelper {
    
    static func loadTextures(from atlas: SKTextureAtlas, withName name: String) -> [SKTexture] {
        var textures = [SKTexture]()
        
        for index in 0..<atlas.textureNames.count {
            let textureName = name + String(index+1)
            textures.append(atlas.textureNamed(textureName))
        }
        
        print(textures)
        return textures
    }
    
}
