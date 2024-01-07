//
//  PrograssScene.swift
//  Fehid
//
//  Created by sumaiya on 28/12/2566 BE.
//

import Foundation
import SpriteKit

class PrograssScene: SKScene {
    

    
//    
//    private var backgroundBar: SKSpriteNode!
//       private var progressBar: SKSpriteNode!
//       
//       var progressValue: CGFloat = 0.0 {
//           didSet {
//               updateProgressBar()
//           }
//       }
//       
//    override init(size: CGSize) {
//           super.init()
//           createProgressBar(size: size)
//       }
//       
//       required init?(coder aDecoder: NSCoder) {
//           fatalError("init(coder:) has not been implemented")
//       }
//       
//       private func createProgressBar(size: CGSize) {
//           // Create background bar
//           backgroundBar = SKSpriteNode(color: UIColor.gray, size: size)
//           addChild(backgroundBar)
//           
//           // Create progress bar
//           progressBar = SKSpriteNode(color: UIColor.green, size: size)
//           progressBar.anchorPoint = CGPoint(x: 0, y: 0.5)
//           addChild(progressBar)
//       }
//       
//       private func updateProgressBar() {
//           let action = SKAction.scaleX(to: progressValue, duration: 0.5)
//           progressBar.run(action)
//       }
    
    
    
    var progressBar: SKSpriteNode!
       var progressCropNode: SKCropNode!
       var progressMaskNode: SKSpriteNode!

       var currentProgress: CGFloat = 0.0

       override func didMove(to view: SKView) {
           setupProgressBar()
       }

       func setupProgressBar() {
           // Create the progress bar background
           progressBar = SKSpriteNode(color: UIColor.gray, size: CGSize(width: 200, height: 20))
           progressBar.position = CGPoint(x: size.width / 2, y: size.height / 2)
           addChild(progressBar)

           // Create the crop node
           progressCropNode = SKCropNode()
           progressCropNode.position = CGPoint(x: -progressBar.size.width / 2, y: 0)
           progressBar.addChild(progressCropNode)

           // Create the mask node for the crop node
           progressMaskNode = SKSpriteNode(color: UIColor.white, size: progressBar.size)
           progressCropNode.maskNode = progressMaskNode
       }

       func updateProgressBar() {
           // Gradually increase the progress over time
           currentProgress += 0.001

           // Update the progress bar with the new value
           setProgress(progress: currentProgress)
       }

       override func update(_ currentTime: TimeInterval) {
           // Called before each frame is rendered
           updateProgressBar()
       }

       // Call this method to update the progress bar with a new progress value
       func setProgress(progress: CGFloat) {
           // Ensure progress is in the valid range (0.0 to 1.0)
           let clampedProgress = max(0.0, min(progress, 1.0))

           // Calculate the width of the mask based on the progress
           let maskWidth = progressBar.size.width * clampedProgress

           // Set the size of the mask node
           progressMaskNode.size.width = maskWidth
       }
   }

   

