//
//  BestSocre.swift
//  sanguocount
//
//  Created by admin on 2021/10/13.
//

import Foundation
let best = "score"
class UserScoreDefault {
   static func getBestSocre() -> Int{
        return UserDefaults.standard.integer(forKey: best)
    }
    
    static func setBestScore(score: Int){
        UserDefaults.standard.set(score, forKey: best)
        UserDefaults.standard.synchronize()
    }
}
