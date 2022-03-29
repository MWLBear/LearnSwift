//
//  PointContainer.swift
//  C5_Spritekit_cat
//
//  Created by mac12 on 2022/3/23.
//

import UIKit
import SpriteKit

class PointContainer: SKNode {
    let cat = Cat()
    let textPoint1 = SKTexture(imageNamed: "pot1")
    let textPoint2 = SKTexture(imageNamed: "pot2")
    var arrPoint = [EPoint]()
    let startIndex = 40
    var currentIndex = 40
    var isFind = false
    
    var arrNext = [Int]()
    
    func onInit() {
        for i in 0...80 {
            let point = EPoint(texture: textPoint1)
            let row = Int(i/9)
            let col = i % 9
            var gap = 0
            if Int(row % 2) == 1 {
                gap = 19
            }
            else {
                
            }
            let width = Int(textPoint1.size().width)
            let x = col * (width + 5) - (9 * width) / 2 + gap
            let y = row * width - (9 * width) / 2
            point.position = CGPoint(x: CGFloat(x), y: CGFloat(y))
            print("width:\(width) - x:\(x) - y:\(y)")
            
            let label = SKLabelNode(text: "\(i)")
            label.zPosition = 33
            point.addChild(label)
            
            if row == 0 || row == 8 || col == 0 || col == 8 {
                point.isEdge = true
            }
            point.index = i
            point.zPosition = 10
            addChild(point)
            arrPoint.append(point)
        }
        onData()
        onCreateRed()
        cat.position = onGetPosition(startIndex)
        cat.zPosition = 20
        addChild(cat)
     
    }
    
    func onData() {
        for point in arrPoint {
            let row = Int(point.index / 9)
            if Int(row % 2) == 1 {
                if point.index - 1 >= 0 && point.index - 1 <= 80 {
                    point.aroundPoint.append(point.index - 1)
                }
                if point.index + 1 >= 0 && point.index + 1 <= 80 {
                    point.aroundPoint.append(point.index + 1)
                }
                if point.index - 8 >= 0 && point.index - 8 <= 80 {
                    point.aroundPoint.append(point.index - 8)
                }
                if point.index - 9 >= 0 && point.index - 9 <= 80 {
                    point.aroundPoint.append(point.index - 9)
                }
                if point.index + 9 >= 0 && point.index + 9 <= 80 {
                    point.aroundPoint.append(point.index + 9)
                }
                
                if point.index + 10 >= 0 && point.index + 10 <= 80 {
                    point.aroundPoint.append(point.index + 10)
                }
            } else {
                if point.index - 1 >= 0 && point.index - 1 <= 80 {
                    point.aroundPoint.append(point.index - 1)
                }
                if point.index + 1 >= 0 && point.index + 1 <= 80 {
                    point.aroundPoint.append(point.index + 1)
                }
                if point.index - 10 >= 0 && point.index - 10 <= 80 {
                    point.aroundPoint.append(point.index - 10)
                }
                if point.index - 9 >= 0 && point.index - 9 <= 80 {
                    point.aroundPoint.append(point.index - 9)
                }
                if point.index + 9 >= 0 && point.index + 9 <= 80 {
                    point.aroundPoint.append(point.index + 9)
                }
                
                if point.index + 8 >= 0 && point.index + 8 <= 80 {
                    point.aroundPoint.append(point.index + 8)
                }
            }
        }
    }
    
    func onSetRed(_ index: Int) {
        arrPoint[index].type = PointType.red
        arrPoint[index].texture = textPoint2
    }
    
    func onCreateRed() {
        for i in 0...8 {
            let r1 = Int(arc4random() % 9) + i * 9
            let r2 = Int(arc4random() % 9) + i * 9
            if r1 != startIndex {
                onSetRed(r1)
            }
            if r2 != startIndex {
                onSetRed(r2)
            }
        }
    }
    
    func onGetPosition(_ index: Int) -> CGPoint {
        return CGPoint(x: arrPoint[index].position.x, y: arrPoint[index].position.y)
    }
    
    func onGetNextPoint(_ index: Int) {
        onSetRed(index)
        for point in arrPoint[currentIndex].aroundPoint {
            if arrPoint[point].isEdge && arrPoint[point].type == PointType.gray {
                gameReset("You win!")
            }
        }
        onResetStep()
        let currentPoint = arrPoint[currentIndex]
        currentPoint.step = 0
        
        arrNext.append(currentIndex)
        onFind(arrNext)
        
        if !isFind {
            gameReset("You loss!")
        }
    }
    
    func onResetStep() {
        arrNext = [Int]()
        isFind = false
        
        for p in arrPoint {
            p.step = 99
            p.prePointIndex = -1
        }
    }
    
    func onFind(_ arrNext:[Int]) {
        if !isFind {
            let arrNext = onGetNexts(arrNext)
            if arrNext.count != 0 {
                onFind(arrNext)
            }
        }
    }
    
    func onGetNexts(_ arrNext:[Int]) -> [Int] {
        let step = arrPoint[arrNext[0]].step + 1
        print("step:\(step)----------:arrNext:\(arrNext) ")
        var tempPoints = [Int]()
        for nextP in arrNext {
            if isFind {
                break
            }
            for p in arrPoint[nextP].aroundPoint {
                print("aroundPoint:\(p)")
                if arrPoint[p].isEdge && arrPoint[p].type == PointType.gray {
                    print("找打了边缘:\(p)")
                    isFind = true
                    onGetPrePoint(arrPoint[p])
                    break
                }
                else if (arrPoint[p].type == PointType.gray) && (arrPoint[p].step > arrPoint[nextP].step) {
                    print("aroundPoint111:\(p)")

                    arrPoint[p].step = step
                    arrPoint[p].prePointIndex = arrPoint[nextP].index
                    print("arrPoint[p].step :\(arrPoint[p].step)")
                    print("arrPoint[p].prePointIndex :\(arrPoint[p].prePointIndex) - arrPoint[nextP].prePointIndex：\(arrPoint[nextP].prePointIndex)")
                    if arrPoint[p].index != arrPoint[nextP].prePointIndex {
                        tempPoints.append(p)
                    }
                }
            }
        }
        return tempPoints
    }
    
    func onGetPrePoint(_ point:EPoint) {
        var p2 = point.aroundPoint[0]
        print("----------------------------")
        print("p2:\(p2)")
        for p in point.aroundPoint {
            if arrPoint[p].step < arrPoint[p2].step {
                p2 = p
            }
        }
        if arrPoint[p2].step == 0 {
            print("point:\(point)")
            cat.position = onGetPosition(point.index)
            self.currentIndex = point.index
            print("currentIndex:\(currentIndex)")
        }
        else {
            onGetPrePoint(arrPoint[p2])
        }
        
    }
    
    func gameReset(_ result: String) {
        let alert = UIAlertController(title: result, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Again", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.scene?.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
        
        for point in arrPoint {
            point.type = PointType.gray
            point.texture = textPoint1
        }
        cat.position = onGetPosition(startIndex)
        currentIndex = startIndex
        onCreateRed()
        onResetStep()
    }
}


