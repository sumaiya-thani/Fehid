//
//  NextStage2to3.swift
//  GameChallange
//
//  Created by sumaiya on 25/12/2566 BE.
//

import Foundation
import Foundation

import SpriteKit


class NextStage2to3:SKScene{
   
    
    override func didMove(to view: SKView) {
        // Set a fixed size or calculate it based on the device's screen size
              let fixedSize = CGSize(width: 2048, height: 1536) // Set your desired width and height

              // Set the scene size
              self.size = fixedSize
        self.scaleMode = .aspectFill 
       
        createBGNodes()
        createGroundNodes()
  
        
        //MARK: -Systems
      
        run(.sequence([
            .wait(forDuration: 5.0),
            .run {
                let scene = GameScene3(size: self.size)
                scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                //scene.size=CGSize(width: 2048, height:   1536)
                scene.scaleMode = self.scaleMode
                
                               
                self.view!.presentScene(scene, transition: .doorsOpenVertical(withDuration: 0.02))
            
                
            }
        
        ]))
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveNodes()
    }
    
    
    
}
//MARK: - Configuration

extension NextStage2to3{
    
    func createBGNodes() {
        let bgNode = SKSpriteNode(imageNamed: "loading-1")
        bgNode.name = "background"
        bgNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // Set the size based on the aspect ratio
        let aspectRatio = bgNode.size.width / bgNode.size.height
        bgNode.size = CGSize(width: self.size.width, height: self.size.width / aspectRatio )
        
        bgNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 )
        bgNode.zPosition = -1.0
        bgNode.setScale(1.0)
        addChild(bgNode)
        
        // Create a texture array for the animation frames
        var animationTextures: [SKTexture] = []
        for i in 1...4 { // Adjust the range based on the number of frames in your animation
            let textureName = "loading-\(i)"
            let texture = SKTexture(imageNamed: textureName)
            animationTextures.append(texture)
        }
        
        // Create an action to animate the background
        let animationAction = SKAction.animate(with: animationTextures, timePerFrame: 0.3)
        
        // Repeat the animation forever
        let repeatAction = SKAction.repeatForever(animationAction)
        
        // Run the animation on the background node
        bgNode.run(repeatAction)
    }
    
    func  createGroundNodes(){
        for i in 0 ... 2{
           let groundNode = SKSpriteNode(imageNamed: "ground")
        groundNode.name="ground"
        groundNode.zPosition = -1.0
        groundNode.anchorPoint = .zero
        groundNode.position = CGPoint(x:-CGFloat(i)*groundNode.frame.width , y:0.0)
           addChild(groundNode)
        }
    }
    
    func moveNodes(){
        enumerateChildNodes(withName: "Untitled_Artwork 6"){(node, _) in
            let node = node as! SKSpriteNode
            node.position.x -= 8.0
            if node.position.x < -self.frame.width{
                node.position.x += node.frame.width*2.0
            }
            
            
        }
        
        enumerateChildNodes(withName: "ground") {(node,_) in
            let node = node as! SKSpriteNode
            node.position.x -= 8.0
            if node.position.x < -self.frame.width{
                node.position.x += node.frame.width*2.0
            }
            
        }
        
    }
   
    
    
    
    
}
