//
//  CGFloat+Ext.swift
//  GameChallange
//
//  Created by sumaiya on 15/12/2566 BE.
//

import Foundation

extension CGFloat{
    
    //func radiansToDegrees() ->{
        
    //}
    
    //here we going to declear the random of the obstcale
    //20 minutes
    static func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
    } //return 0,1
    
    static func random(min:CGFloat,max:CGFloat) -> CGFloat{
        assert(min < max)
        return CGFloat.random() * (max - min) + min //return main or max
    }
}
