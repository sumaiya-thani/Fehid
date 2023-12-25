//
//  GameViewController.swift
//  GameChallange
//
//  Created by sumaiya on 14/12/2566 BE.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "Story1")  {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//                scene.size=CGSize(width: 2048, height:   1536)
//                
//                
//                
//                
//                // Present the scene
//                view.presentScene(scene)
//            }
//            
//            view.ignoresSiblingOrder = true
//            view.showsNodeCount=true
//            view.showsPhysics=false
//            view.showsFPS=true
//            
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
        
                    if let view = self.view as? SKView {
                        // Create an instance of IntroScene
                        let introScene = Story1(size: CGSize(width: 2048, height: 1536))
        
                        // Set the scale mode to scale to fit the window
                        introScene.scaleMode = .aspectFill
        
                        // Present the IntroScene
                        view.presentScene(introScene)
        
                        view.ignoresSiblingOrder = true
                        view.showsNodeCount = false
                        view.showsPhysics = false
                        view.showsFPS = false
        
        
                    }
    }
    
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
