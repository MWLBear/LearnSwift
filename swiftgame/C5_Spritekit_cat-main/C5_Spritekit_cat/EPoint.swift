//
//  EPoint.swift
//  C5_Spritekit_cat
//
//  Created by mac12 on 2022/3/23.
//

import UIKit
import SpriteKit

enum PointType: Int {
    case gray = 0
    case red = 1
}
class EPoint: SKSpriteNode {
    var prePointIndex = -1
    var aroundPoint = [Int]()
    var step = 99
    var index = 0
    var type = PointType.gray
    var isEdge = false
}
