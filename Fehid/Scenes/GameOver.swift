//
//  GameOver.swift
//  GameChallange
//
//  Created by sumaiya on 21/12/2566 BE.
//

import SpriteKit


class GameOver:SKScene{
    
    //MARK: -Systems
    
    override func didMove(to view: SKView) {
        createBGNodes()
        createGroundNodes()
 
       
           
        run(.sequence([
            .wait(forDuration: 5.0),
            .run {
                let scene = MainMenu(size: self.size)
                
                //scene.size=CGSize(width: 2048, height:   1536)
                scene.scaleMode = self.scaleMode
                self.view!.presentScene(scene, transition: .doorsOpenVertical(withDuration: 0.02))
            }
        
        ]))
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
    
}
//MARK: - Configuration

extension GameOver{
    
    func createBGNodes(){
        for i in 0 ... 2 {
            let bgNode = SKSpriteNode(imageNamed: "GameOver ")
            bgNode.name = "background"
            bgNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            // Set the size based on the aspect ratio
            let aspectRatio = bgNode.size.width / bgNode.size.height
            bgNode.size = CGSize(width: self.size.width, height: self.size.width / aspectRatio)
            
            bgNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            bgNode.zPosition = -1.0
            addChild(bgNode)
            
        }
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
    
    
    



