//
//  Types.swift
//  GameChallange
//
//  Created by sumaiya on 18/12/2566 BE.
//

import Foundation

struct PhysicsCategory{
    
    static let Player:       UInt32 = 0b1 //1
    static let Block:       UInt32 = 0b10 //2
    static let Obstacle:       UInt32 = 0b100 //4
    static let Hole:       UInt32 = 0b1000 //8
    static let Ground:       UInt32 = 0b10000 //16
    static let Coin:       UInt32 = 0b100000 //32
    
}
