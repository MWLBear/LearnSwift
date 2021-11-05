//
//  Configuration.swift
//  Birds
//
//  Created by Roman Yakovliev on 17.10.2021.
//

import CoreGraphics

struct ZPositions {
    static let background: CGFloat = 0
    static let obstacles: CGFloat = 1
    static let hudBackground: CGFloat = 10
    static let hudLabel: CGFloat = 11
}

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max
    static let edge: UInt32 = 0x1 // 01
    static let bird: UInt32 = 0x1 << 1 // 10
    static let block: UInt32 = 0x1 << 2 // 100 ?
}

extension CGPoint {
    
    static public func * (left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x * right, y: left.y * right)
    }
    
    static public func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    static public func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    
}
