//
//  ScoreGenerator.swift
//  GameChallange
//
//  Created by sumaiya on 20/12/2566 BE.
//

import Foundation

class ScoreGenerator{
    static let sharedInstance = ScoreGenerator()
    private init() {}
    
    static let KeyHighscore = "KeyHighscore"
    static let KeyScore = "KeyScore"
    
    func setScore(_ score:Int){
        UserDefaults.standard.integer(forKey: ScoreGenerator.KeyScore)
        
    }
    func getScore() -> Int {
        return UserDefaults.standard.integer(forKey: ScoreGenerator.KeyHighscore)
    }
    func setHighscore(_ highscore:Int){
        UserDefaults.standard.set(highscore, forKey: ScoreGenerator.KeyHighscore)
    }
    func getHighscore() -> Int {
        return UserDefaults.standard.integer(forKey: ScoreGenerator.KeyHighscore)
    }
    
    
}
