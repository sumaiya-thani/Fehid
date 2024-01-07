//
//  PreGame.swift
//  Fehid
//
//  Created by sumaiya on 05/01/2567 BE.
//


import Foundation
import SpriteKit
import GameplayKit

class PreGame: SKScene {
    
    
    
    
    
    //MARK: - Poropoties
    var ground:SKSpriteNode!
    var player:SKSpriteNode!
    var dog:SKSpriteNode!
    var playerTextures: [SKTexture] = []
    var dogTextures : [SKTexture] = []
    var obstacle:[SKSpriteNode]=[]
    var obstacleTextures: [SKTexture] = []
    //Camera
    var camerNode = SKCameraNode()
    var cameraMovePointPerSecound:CGFloat=700.0
    var lastUpdateTime:TimeInterval=0.0
    var dt:TimeInterval=0.0
    var isTime:CGFloat = 3.0
    //Coin + GameOver
  
    let soundPlayer = SoundPlayer()
    
    //end coin
    
    //start pauss
    
    var pauseNode:SKSpriteNode!
    var containerNode=SKNode()
    
    //end start pauss
    //prograss
    var progressBar: SKSpriteNode!
    var progressValue: CGFloat = 0.0
    let holeSprite = SKSpriteNode(imageNamed: "hole")
    //Sounds
    var soundCoin = SKAction.playSoundFileNamed("coin.mp3")
    
    var soundCollison = SKAction.playSoundFileNamed("collision.wav")
    var soundHole = SKAction.playSoundFileNamed("hole.m4a")
    var soundRun = SKAction.playSoundFileNamed("running-sounds.mp3")
    //end Sounds
    
    //Start Player Jump
    
    var onGround = true
    //السرعه
    var velocityY:CGFloat = 0.0
    var gravity:CGFloat = 0.6
    var playerPosY:CGFloat = 0.0
    
    
    //End Player Jump
    
    
    
    
    
    var playableRect:CGRect{
        let ratio:CGFloat
        
        switch UIScreen.main.nativeBounds.height{
        case 1170,2688,2436:
            ratio = 2.16
        default:
            ratio = 19.5
            //16/9
        }
        let playableHight=size.width/ratio
        
        let playableMargin=(size.height - playableHight)/2.0
        return CGRect(x: 0.0, y: playableMargin, width: size.width, height: playableHight)
    }
    
    
    var cameraRec:CGRect{
        let width=playableRect.width
        let heigh=playableRect.height
        let x=camerNode.position.x-size.width/2.0 + (size.width-width)/2.0
        let y=camerNode.position.y - size.height/2.0+(size.height-heigh)/2.0
        return CGRect(x: x, y: y, width: width, height: heigh)
    }
    //endOfCamera
    //MARK: - System
    func presentNextSceneWithOverlay() {
          // Create an overlay node
          let overlayNode = SKSpriteNode(color: SKColor.black, size: self.size)
          overlayNode.alpha = 0.0
          overlayNode.zPosition = 1000 // Make sure it's above everything

          // Add the overlay node to the scene
          self.addChild(overlayNode)

          // Create an action to gradually increase the alpha of the overlay (fade in)
          let fadeInAction = SKAction.fadeAlpha(to: 0.7, duration: 1.0) // Adjust the duration and alpha as needed

          // Create an action to present the next scene
          let presentNextSceneAction = SKAction.run { [weak self] in
              // Create an instance of the next scene class
              let nextScene = GameScene(size: self?.size ?? CGSize(width: 0, height: 0))
              nextScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
              // Set any parameters or properties on the next scene here if needed
              nextScene.scaleMode = self?.scaleMode ?? .aspectFill

              // Present the new scene with a transition
              self?.view?.presentScene(nextScene, transition: .doorsOpenVertical(withDuration: 0.01))
          }

          // Run the actions sequentially
          overlayNode.run(SKAction.sequence([fadeInAction, presentNextSceneAction]))
      }

      // Call this function with a run block
      func startSceneTransition() {
          self.run(.sequence([
              .wait(forDuration: 5.0),
              .run {
                  self.presentNextSceneWithOverlay()
              }
          ]))
      }


    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0{
            dt = currentTime - lastUpdateTime
            
        }else{
            dt=0
        }
       
        lastUpdateTime=currentTime
        moveCamera()
//        movePlayer()
//        movedog()
//   
        
        movePlayerAndDog()
        //movming
        velocityY += gravity
        player.position.y -= velocityY
        if player.position.y<playerPosY{
            player.position.y = playerPosY
            velocityY = 0.0
            onGround = true
        }
        
        //here if he touch vthe bounderies
        // here the size is not same
        

       
        
       // print(dt)
    }
    
    override func didMove(to view: SKView) {
        SetupNodes()
        
        let waitAction = SKAction.wait(forDuration: 5.0)
                let presentNextSceneAction = SKAction.run { [weak self] in
                    self?.presentNextSceneWithOverlay()
                }

                self.run(SKAction.sequence([waitAction, presentNextSceneAction]))

        
        
        
    }

    //Tuch Begin
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
     
    }
    
  

}
//MARK: -Configuration
extension PreGame{
    
    
    func SetupNodes(){

        createBG2()

        createDog()
        createGround()
        createPlayer()
        setupCamera()
  
       
        createProgressBar()
        increaseProgress()
        
    }
    //set up physics
    
    func setupPhysics(){
        
        physicsWorld.contactDelegate = self
    }
    
    func createProgressBar() {
        
        
        let backgroundBar = SKSpriteNode(color: UIColor.brown, size: CGSize(width: 800, height: 30))
        backgroundBar.anchorPoint = CGPoint(x: 0, y: 0.5)
        backgroundBar.position = CGPoint(x: -playableRect.width/2.0 + backgroundBar.frame.width - 150, y:
                                            playableRect.height/2.0 - backgroundBar.frame.height/2.0+200)
        backgroundBar.zPosition=50.0
        
        
        camerNode.addChild(backgroundBar)
        
        // Create progress bar
        progressBar = SKSpriteNode(color: UIColor.white, size: CGSize(width: 800, height: 40))
        
        progressBar.anchorPoint = CGPoint(x: 0, y: 0.5)
        progressBar.position = CGPoint(x: -playableRect.width/2.0 + progressBar.frame.width - 150, y:
                                        playableRect.height/2.0 - progressBar.frame.height/2.0+200)
        
        progressBar.zPosition=50.0
        
        camerNode.addChild(progressBar)
        progressValue = 0.0
        
    }

    func updateProgressBar() {
        let action = SKAction.scaleX(to: progressValue, duration: 1.0)
        progressBar.run(action)
    }


    func increaseProgress() {
        let totalDuration: TimeInterval = 5.0  // Total duration for the progress to reach 1.0 (fully filled)
        let updateInterval: TimeInterval = 1.0  // Update interval (1 second)

        var elapsedTime: TimeInterval = 0.0
        Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }

            elapsedTime += updateInterval

            // Calculate progress based on elapsed time and total duration
            let progressPercentage = elapsedTime / totalDuration
            self.progressValue = min(1.0, progressPercentage)

            // Update the progress bar
            self.updateProgressBar()

            // Check if the progress is complete
            if elapsedTime >= totalDuration {
                timer.invalidate()
            }
        }
    }
    
    
    
    
 
    func createBG2(){
        let backgroundImageSize = CGSize(width: 15000, height: 1500)
        
  
        for i in 0...2 {
            let backGround=SKSpriteNode(imageNamed: "Untitled_Artwork 6")
          
            backGround.alpha = 0.50
            backGround.anchorPoint = .zero
            
            backGround.position = CGPoint(x: CGFloat(i) * backgroundImageSize.width - backgroundImageSize.width / 10,
                                        y: -backgroundImageSize.height / 3)
            
            backGround.zPosition = -1.0
            backGround.name = "Background2\(i)"
            
            
            addChild(backGround)
           
            
        }
        
     
        
        
    }
    
    
    


    
    
    
    
    
    
    func createGround(){
     
        for i in 0...2{
            ground=SKSpriteNode(imageNamed: "ground")
           // ground.anchorPoint = .zero
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.0)
            ground.zPosition = 1.0
            let yPos = -scene!.size.height / 2.0 + ground.size.height / 2.0
            ground.position=CGPoint(x: CGFloat(i)*ground.frame.width, y: yPos)
            ground.alpha = 0.50
            
            //phyisics
            
            ground.physicsBody=SKPhysicsBody(rectangleOf: ground.size)
            ground.physicsBody!.isDynamic=false
            ground.physicsBody!.affectedByGravity = false
            ground.physicsBody!.categoryBitMask = PhysicsCategory.Ground
            
            ground.name="Ground"
            
            addChild(ground)
            //addGroundParticles(parentNode: ground)
        }
        

        
    }
    //particales
    func addRunParticles(parentNode: SKSpriteNode) {
        if let run = SKEmitterNode(fileNamed: "ParticleRun") {
            run.name = "run"
            run.zPosition = 1.0 // Adjust the zPosition to ensure particles are behind the player
                   run.position = CGPoint(x: 0, y: -player.size.height - 100 ) // Adjust the position relative to the player
            parentNode.addChild(run)
        }
    }
    
    
    
    //particales
    func addGroundParticles(parentNode: SKSpriteNode) {
        if let groundDust = SKEmitterNode(fileNamed: "GroundDust") {
            groundDust.name = "run"
            groundDust.zPosition = 1.0 // Adjust the zPosition to ensure particles are behind the player
                  // run.position = CGPoint(x: 0, y: -player.size.height ) // Adjust the position relative to the player
            parentNode.addChild(groundDust)
        }
    }
    
    func createPlayer(){
        
        // Load textures for animation
               for i in 1...4 {
                   let textureName = "boy-\(i)"
                   let texture = SKTexture(imageNamed: textureName)
                   playerTextures.append(texture)
                   for texture in playerTextures {
                       print("Loaded texture: \(texture)")
                   }
               }
        
       
        // Create player with the initial texture
                player = SKSpriteNode(texture: playerTextures.first)
        player.name="Player"
        player.zPosition=5.0
        player.setScale(0.23)

        player.position=CGPoint(x:  -playableRect.width / 2.0, y: -160)
       
        //physics
        
        player.physicsBody = SKPhysicsBody(
            circleOfRadius: player.size.width/2.2)
              player.physicsBody!.affectedByGravity = false
              //Restitution = ارتداد
              player.physicsBody!.restitution = 0.0
              player.physicsBody!.categoryBitMask = PhysicsCategory.Player
              player.physicsBody!.contactTestBitMask =
              PhysicsCategory.Block | PhysicsCategory.Obstacle |
        PhysicsCategory.Coin | PhysicsCategory.Hole
        
        playerPosY=player.position.y
        
        addChild(player)
        // Start the animation
               startPlayerAnimation()
        addRunParticles(parentNode: player)
        
    }
    func startPlayerAnimation() {
           let animation = SKAction.animate(with: playerTextures, timePerFrame: 0.2)
           let repeatAction = SKAction.repeatForever(animation)
           player.run(repeatAction)
        run(soundRun)
     
       }
    func startDogAnimation() {
           let animation = SKAction.animate(with:dogTextures, timePerFrame: 0.2)
           let repeatAction = SKAction.repeatForever(animation)
           dog.run(repeatAction)
       
     
       }

    
    
    //dog
    
    func createDog(){
        
        // Load textures for animation
               for i in 1...4 {
                   let textureName = "dog-\(i)"
                   let texture = SKTexture(imageNamed: textureName)
                   dogTextures.append(texture)
                   for texture in dogTextures {
                       print("Loaded texture: \(texture)")
                   }
               }
        
       
        // Create player with the initial texture
                dog = SKSpriteNode(texture: dogTextures.first)
        dog.name="Dog"
        dog.zPosition=5.0
        dog.setScale(0.23)

        dog.position=CGPoint(x: 100, y: -160)
       
        //physics
        
        dog.physicsBody = SKPhysicsBody(
            circleOfRadius: dog.size.width/2.2)
        dog.physicsBody!.affectedByGravity = false
              //Restitution = ارتداد
        dog.physicsBody!.restitution = 0.0
        dog.physicsBody!.categoryBitMask = PhysicsCategory.Player
        dog.physicsBody!.contactTestBitMask =
              PhysicsCategory.Block | PhysicsCategory.Obstacle |
        PhysicsCategory.Coin | PhysicsCategory.Hole
        
        playerPosY=dog.position.y
        
        addChild(dog)
        // Start the animation
        startDogAnimation()
       
        
    }
 
    func setupCamera(){
        addChild(camerNode)
        camera=camerNode
        camerNode.position=CGPoint(x: frame.midX, y: frame.midY)
        
    }
    func moveCamera(){
        let amountToMove=CGPoint(x: cameraMovePointPerSecound*CGFloat(dt), y: 0.0)
        

        camerNode.position+=amountToMove
        
        
        
        enumerateChildNodes(withName: "Background"){
            (node,_) in
            let node=node as! SKSpriteNode
            
             if node.position.x + node.frame.width <  self.cameraRec.origin.x{
                 node.position=CGPoint(x: node.position.x+node.frame.width*3.0, y: node.position.y)
                
            }
           
        }
        
     
      
        
        enumerateChildNodes(withName: "Ground"){
            (node,_) in
            let node=node as! SKSpriteNode
            if node.position.x + node.frame.width <  self.cameraRec.origin.x{
                node.position=CGPoint(x: node.position.x+node.frame.width*3.0, y: node.position.y)
            }
            
        }
       
    }
    
    
    //Player
        //I have a rotate behaiv
//    func movePlayer(){
//   
//        let amountToMove=cameraMovePointPerSecound*CGFloat(dt)
//        player.position.x += amountToMove
//        
//    }
//    func movedog(){
//   
//        let amountToMove=cameraMovePointPerSecound*CGFloat(dt)
//        dog.position.x += amountToMove + 4
//        
//        
//    }
//    func movePlayer() {
//        let amountToMove = cameraMovePointPerSecound * CGFloat(dt)
//        let newPosition = CGPoint(x: player.position.x + amountToMove, y: player.position.y)
//        player.position = validatePlayerPosition(newPosition)
//    }
//    func validatePlayerPosition(_ position: CGPoint) -> CGPoint {
//        // Ensure the player stays within the playable area
//        let minX = cameraRec.origin.x - cameraRec.size.width / 2.0
//        let maxX = cameraRec.origin.x + cameraRec.size.width / 2.0
//        let newX = max(min(position.x, maxX), minX)
//
//        return CGPoint(x: newX, y: position.y)
//    }
//
//    func movedog() {
//        let amountToMove = cameraMovePointPerSecound * CGFloat(dt) + 4  // Add an offset for the dog
//        let newPosition = CGPoint(x: dog.position.x + amountToMove, y: dog.position.y)
//        dog.position = validatePlayerPosition(newPosition)
//    }
    func movePlayerAndDog() {
        let amountToMove = cameraMovePointPerSecound * CGFloat(dt)

        // Move player
        let newPlayerPosition = CGPoint(x: player.position.x + amountToMove + 4, y: player.position.y)
        player.position = newPlayerPosition

        // Move dog with an offset
        let newDogPosition = CGPoint(x: dog.position.x + amountToMove + 2, y: dog.position.y)
        dog.position = newDogPosition
    }
    
    func setupHole(){
        
        // Third obstacle - Hole
         //let holeSprite = SKSpriteNode(imageNamed: "hole")
        holeSprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: holeSprite.size.width, height: holeSprite.size.height - 100))
         holeSprite.name = "Hole"
         holeSprite.setScale(0.85)
        holeSprite.zPosition = 50.0
         holeSprite.physicsBody!.categoryBitMask = PhysicsCategory.Hole
       // holeSprite.position=CGPoint(x: cameraRec.maxX+holeSprite.frame.width/2.0, y:-200)
        holeSprite.position = CGPoint(x: cameraRec.maxX - holeSprite.frame.width / 2.0 + 40000, y: -200)
        holeSprite.physicsBody!.affectedByGravity = false
        holeSprite.physicsBody!.isDynamic = false
         addChild(holeSprite)
        addGroundParticles(parentNode: holeSprite)
        
    }
    

        
        
        
        
        
        
        
        
        
    
}
// MARK: - Sk

extension PreGame:SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
       
    }
}

