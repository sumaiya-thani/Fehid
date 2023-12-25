//
//  SKAction+Ext.swift
//  GameChallange
//
//  Created by sumaiya on 21/12/2566 BE.
//

import SpriteKit


extension SKAction {
    
    class func playSoundFileNamed(_ fileNamed:String) -> SKAction {
        if !effectEnabled {return SKAction()}
        return SKAction.playSoundFileNamed(fileNamed , waitForCompletion:  false)
        
    }
}
private let KeyEffect = "KeyEffect"
var effectEnabled: Bool = {
    return !UserDefaults.standard.bool(forKey:  KeyEffect)
    
}(){
    
    
    didSet{
        let value = !effectEnabled
        UserDefaults.standard.set(value, forKey: KeyEffect)
        if value{
            SKAction.stop()
        }
    }
}
