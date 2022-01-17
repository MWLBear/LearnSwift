//
//  GameHandler.swift
//  ColorGame
//
//  Created by Kas Song on 12/21/21.
//

import Foundation

class GameHandler {
    
    static let shared = GameHandler()
    
    // MARK: - Properties
    var score: Int = 0
    var highScore: Int
    
    // MARK: - Lifecycle
    private init() {
        highScore = UserDefaults.standard.integer(forKey: "highScore")
    }
    
    // MARK: - Helpers
    func saveGameStats() {
        highScore = max(score, highScore)
        UserDefaults.standard.set(highScore, forKey: "highScore")
    }
}
