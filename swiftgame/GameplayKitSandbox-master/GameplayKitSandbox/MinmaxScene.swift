//
//  MinmaxScene.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/22.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import SpriteKit
import GameplayKit

class MinmaxScene: ExampleScene {

    let cellSize: CGFloat = 60.0
    let margin: CGFloat = 2.0

    var board: Board!
    var cells: [SKSpriteNode]!
    var strategist: GKMinmaxStrategist!

    var didGameOver: ((MinmaxScene, String) -> Void)?

    override func createSceneContents() {
        board = Board(level: 3)
        //board.debug = true

        strategist = GKMinmaxStrategist()
        strategist.gameModel = board
        strategist.maxLookAheadDepth = board.level * 2 - 1

        let step = cellSize + margin

        let backgroundSize = step * CGFloat(board.level) - margin
        let background = SKSpriteNode(color: SKColor.white, size: CGSize(width: backgroundSize, height: backgroundSize))
        background.position = center
        addChild(background)

        cells = [SKSpriteNode]()
        let base = CGFloat(board.level - 1) * 0.5
        let baseX = center.x - step * base
        let baseY = center.y - step * base
        for i in 0..<board.cells.count {
            let cell = SKSpriteNode(color: backgroundColor, size: CGSize(width: cellSize, height: cellSize))
            let x = baseX + floor(CGFloat(i) / CGFloat(board.level)) * step
            let y = baseY + CGFloat(i % board.level) * step
            cell.position = CGPoint(x: x, y: y)
            addChild(cell)
            cells.append(cell)
        }

        /*
        let index = GKRandomDistribution(lowestValue: 0, highestValue: board.cells.count - 1).nextInt()
        board.updateCell(index)
        for _ in 0..<board.cells.count - 1 {
            if let move = strategist.bestMoveForPlayer(board.currentPlayer) as? Move {
                board.applyGameModelUpdate(move)
            }
            updateBoard()
        }
        */
    }

    func updateBoard() {
        for (i, cell) in board.cells.enumerated() {
            cells[i].removeAllChildren()
            let label = SKLabelNode(text: cell.text())
            label.fontName = "Chalkduster"
            label.fontSize = 70.0
            label.fontColor = SKColor.white
            label.verticalAlignmentMode = .center
            cells[i].addChild(label)
        }

        if board.isGameOver() {
            let message: String
            if board.isWin(for: Player.oPlayer()) {
                message = "Won"
            } else if board.isWin(for: Player.xPlayer()) {
                message = "Lost"
            } else {
                message = "Draw"
            }
            if let didGameOver = didGameOver {
                didGameOver(self, message)
            }
        }
    }

    func reset() {
        removeAllChildren()
        createSceneContents()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        if let node = atPoint(location) as? SKSpriteNode {
            if let index = cells.firstIndex(of: node) {
                board.updateCell(index)
                updateBoard()
                if let move = strategist.bestMove(for: board.currentPlayer) as? Move {
                    board.apply(move)
                    updateBoard()
                }
            }
        }
    }
}
