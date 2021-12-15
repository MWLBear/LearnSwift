//
//  Board.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/23.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import GameplayKit

class Board: NSObject, GKGameModel {

    let level: Int
    var debug = false

    var currentPlayer: Player
    var cells: [Mark]

    init(level: Int) {
        self.level = level
        currentPlayer = Player.oPlayer()
        cells = Array<Mark>(repeating: .none, count: level * level)
    }

    func updateCell(_ index: Int) {
        if cells[index] == .none {
            cells[index] = currentPlayer.mark
            currentPlayer = currentPlayer.opponent()!
        }
    }

    func isGameOver() -> Bool {
        return cells.filter { $0 == Mark.none }.isEmpty || isWin(for: currentPlayer) || isLoss(for: currentPlayer)
    }

    func lines() -> [[Int]] {
        var lines = [[Int]]()

        for i in 0..<level {
            var line = [Int]()
            for j in 0..<level {
                line.append(j + level * i)
            }
            lines.append(line)
        }

        for i in 0..<level {
            var line = [Int]()
            for j in 0..<level {
                line.append(i + level * j)
            }
            lines.append(line)
        }

        for i in [0] {
            var line = [Int]()
            for j in 0..<level {
                line.append(i + (level + 1) * j)
            }
            lines.append(line)
        }

        for i in [level - 1] {
            var line = [Int]()
            for j in 0..<level {
                line.append(i + (level - 1) * j)
            }
            lines.append(line)
        }
        
        return lines
    }

    func checksForPlayer(_ player: GKGameModelPlayer) -> Int {
        guard let player = player as? Player else { return 0 }

        var count = 0

        for line in lines() {
            var opponentCount = 0
            var noneCount = 0
            for l in line {
                switch cells[l] {
                case player.mark:
                    break
                case player.opponent()!.mark:
                    opponentCount += 1
                default:
                    noneCount += 1
                }
            }

            if noneCount == 1 && opponentCount == level - 1 {
                count += 1
            }
        }

        return count
    }

    // MARK: - GKGameModel

    var players: [GKGameModelPlayer]? {
        return Player.all()
    }
    var activePlayer: GKGameModelPlayer? {
        return currentPlayer
    }

    func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
        var moves = [Move]()
        for (i, cell) in cells.enumerated() {
            if cell == .none {
                moves.append(Move(index: i))
            }
        }
        return moves
    }

    func apply(_ gameModelUpdate: GKGameModelUpdate) {
        if let move = gameModelUpdate as? Move {
            updateCell(move.index)
        }
    }

    func setGameModel(_ gameModel: GKGameModel) {
        if let board = gameModel as? Board {
            cells = board.cells
            debug = board.debug
            currentPlayer = board.currentPlayer
        }
    }

    func copy(with zone: NSZone?) -> Any {
        let board = Board(level: self.level)
        board.setGameModel(self)
        return board
    }

    func isWin(for player: GKGameModelPlayer) -> Bool {
        guard let player = player as? Player else { return false }

        for line in lines() {
            var count = 0
            for l in line {
                if cells[l] == player.mark {
                    count += 1
                }
            }
            if count == level {
                return true
            }
        }

        return false
    }

    func isLoss(for player: GKGameModelPlayer) -> Bool {
        guard let player = player as? Player else { return false }

        return isWin(for: player.opponent()!)
    }

    func score(for player: GKGameModelPlayer) -> Int {
        let score: Int

        score = -checksForPlayer(player)

        if debug {
            var log = ""
            for i in 0..<level {
                for j in 0..<level {
                    let text = cells[level - i - 1 + j * level].text()
                    log += text.isEmpty ? "*" : text
                }
                log += "\n"
            }
            log += "score: \(score)\n"
            print(log)
        }

        return score
    }
}
