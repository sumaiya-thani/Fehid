//
//  Story3.swift
//  Fehid
//
//  Created by sumaiya on 25/12/2566 BE.
//


import Foundation
import SpriteKit

class Story3 : SKScene {
    
    override func didMove(to view: SKView) {
        // Set a fixed size or calculate it based on the device's screen size
              let fixedSize = CGSize(width: 2048, height: 1536) // Set your desired width and height

              // Set the scene size
              self.size = fixedSize
        
        //addNextLabel()
        setupBG()
        
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)

            // Transition to the next scene when touched
            goToNextScene()
        
        }
    
    
}
extension Story3{
    
    
    
    
    func setupBG() {
        let bgNode = SKSpriteNode(imageNamed: "story3")
        
        bgNode.zPosition = -1.0
        bgNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        // Set the size based on the aspect ratio
        let aspectRatio = bgNode.size.width / bgNode.size.height
        bgNode.size = CGSize(width: self.size.width, height: self.size.width / aspectRatio)
        
        // Set the position to the center of the scene
        bgNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        
        
        addChild(bgNode)
        
    }
    
    func addNextLabel() {
            // Create a label node
            let nextLabel = SKLabelNode(text: " أبدأ")
            nextLabel.fontSize = 50
            nextLabel.fontColor = SKColor.white
        
        nextLabel.position = CGPoint(x: self.size.width / 2+700, y: self.size.height / 2 - 300)
        nextLabel.zPosition = 15
            
            // Add the label node to the scene
            addChild(nextLabel)
        }
    func goToNextScene() {
            // Create the next scene
        let scene = PreGame(size: size)
        scene.scaleMode = .aspectFill

        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)

            // Transition to the next scene
            view!.presentScene(scene)
        }
    
}
