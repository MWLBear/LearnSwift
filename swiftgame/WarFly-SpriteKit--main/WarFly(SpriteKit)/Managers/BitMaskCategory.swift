//
//  BitMaskCategory.swift
//  WarFly(SpriteKit)
//
//  Created by Oleg Kanatov on 13.10.21.
//

import SpriteKit

extension SKPhysicsBody {
    var category: BitMaskCategory {
        get {
            return BitMaskCategory(rawValue: self.categoryBitMask)
        }
        
        set {
            self.categoryBitMask = newValue.rawValue
        }
    }
}

struct BitMaskCategory: OptionSet {
    let rawValue: UInt32
    
    static let none     = BitMaskCategory(rawValue: 0 << 0)
    static let player   = BitMaskCategory(rawValue: 1 << 0)
    static let enemy    = BitMaskCategory(rawValue: 1 << 1)
    static let powerUp  = BitMaskCategory(rawValue: 1 << 2)
    static let shot     = BitMaskCategory(rawValue: 1 << 3)
    static let all      = BitMaskCategory(rawValue: UInt32.max)
}
