//
//  GameScene.swift
//  GameChallange
//
//  Created by sumaiya on 14/12/2566 BE.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
      

    
  //MARK: - Poropoties
    var ground:SKSpriteNode!
    var player:SKSpriteNode!
    var playerTextures: [SKTexture] = []
    var snakeTextures : [SKTexture] = []
    let holeSprite = SKSpriteNode(imageNamed: "hole")
    var obstacle:[SKSpriteNode]=[]
    var obstacleTextures: [SKTexture] = []
    //Camera
    var camerNode = SKCameraNode()
    var cameraMovePointPerSecound:CGFloat=450.0
    var lastUpdateTime:TimeInterval=0.0
    var dt:TimeInterval=0.0
    var isTime:CGFloat = 3.0
    //Coin + GameOver
    
    var coin:SKSpriteNode!
    var numScore: Int = 0
    var gameOver = false
    var life:Int = 3
    var lifeNode:[SKSpriteNode] = []
    var scoreLable = SKLabelNode(fontNamed: "Krungthep")
    
    var coinIcon:SKSpriteNode!
    
    let soundPlayer = SoundPlayer()
    
    //end coin
    
    //start pauss
    
    var pauseNode:SKSpriteNode!
    var containerNode=SKNode()
    
    //end start pauss
    
    //prograss
    var progressBar: SKSpriteNode!
       var progressValue: CGFloat = 0.0
    
    //Sounds
    
   var soundCoin = SKAction.playSoundFileNamed("coin.mp3")
var soundJump = SKAction.playSoundFileNamed("jump.wav")
    var soundCollison = SKAction.playSoundFileNamed("collision.wav")
    
    var soundRun = SKAction.playSoundFileNamed("running-sounds.mp3")
    var soundHole = SKAction.playSoundFileNamed("hole.mp3")
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
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0{
            dt = currentTime - lastUpdateTime
            
        }else{
            dt=0
        }
        lastUpdateTime=currentTime
        moveCamera()
        movePlayer()
      
           
        //increaseProgress()

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
        
        if gameOver{
            let scene = GameOver(size: size)
            scene.scaleMode = scaleMode
            //scene.scaleMode = .aspectFit
            scene.size=CGSize(width: 2048, height:   1536)
  
        
       //  view!.presentScene(scene)
            view!.presentScene(scene, transition: .doorsCloseHorizontal(withDuration: 0.4))
            

           
        }
        bounCheckPlayer()
        
       // print(dt)
    }
    
    override func didMove(to view: SKView) {
        SetupNodes()
        
        
        
        
        //here the background sound
        SKTAudio.sharedInstance().playBGmusic("Youm-El-Ta2ses-60Sec.mp3")
    }

    //Tuch Begin
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
            //pauss
        
        guard let touch = touches.first else {return}
        let node = atPoint(touch.location(in: self))
        if node.name == "pause"{
            if isPaused { return }
            createPanel()
            lastUpdateTime = 0.0
            dt = 0.0
            isPaused = true
        }else if node.name == "resume"{
            containerNode.removeFromParent()
            isPaused = false
        }else if node.name == "quit"{
            
            //MARK: - My Main
          let scene = MainMenu(size: size)
            scene.scaleMode = scaleMode
            view!.presentScene(scene , transition: .doorsCloseVertical(withDuration: 0.8))
        }else{
            if !isPaused{
                if onGround{
                    onGround=false
                    velocityY = -25.0
                    //it was -25.0
                    
                   // soundPlayer.playSound(named: "jump", fileType: "wav")
                    run(soundJump)
                }
            }
        }
        //end of pauss
        
        
        //ground
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if velocityY < -12.5 {
            velocityY = -12.5
        }
    }

}
//MARK: -Configuration
extension GameScene{
    
    
    func SetupNodes(){
        createBG()
        //createBG2()
        //createBG3()
     
        createGround()
        createPlayer()
        setupCamera()
        setupObsticales()
        spawnObstacles()
        setupCoin()
        spawnCoin()
        setupPhysics()
        setupLife()
        setupScore()
        setupPause()
       // createProgressBar()
       // updateProgressBar()
       
     
    }
    
    
   
            
            
    
    
    // MARK: - Prograss bar
    
    
    
    
//    func createProgressBar() {
//       
//        // Set the desired grayscale value (from 0.0 to 1.0)
//        let grayValue: CGFloat = 0.5  // Adjust this value based on your desired shade of gray
//
//        // Set the desired alpha (opacity) value (from 0.0 to 1.0)
//        let alpha: CGFloat = 0.5  // Adjust this value based on your desired opacity
//
//        // Create UIColor with gray values and opacity
//       
//
//           // Create background bar
//        let backgroundBar = SKSpriteNode(color: UIColor.brown, size: CGSize(width: 800, height: 10))
//        backgroundBar.anchorPoint = CGPoint(x: 0, y: 0.5)
//        backgroundBar.position = CGPoint(x: -playableRect.width/2.0 + backgroundBar.frame.width - 150, y:
//                                        playableRect.height/2.0 - backgroundBar.frame.height/2.0+350)
//        backgroundBar.zPosition=50.0
//       
//        
//        camerNode.addChild(backgroundBar)
//           
//           // Create progress bar
//        progressBar = SKSpriteNode(color: UIColor.white, size: CGSize(width: 800, height: 10))
//        
//           progressBar.anchorPoint = CGPoint(x: 0, y: 0.5)
//        progressBar.anchorPoint = CGPoint(x: 0, y: 0.5)
//        progressBar.position = CGPoint(x: -playableRect.width/2.0 + progressBar.frame.width - 150, y:
//                                        playableRect.height/2.0 - progressBar.frame.height/2.0+350)
//        
//        progressBar.zPosition=50.0
//     
//        camerNode.addChild(progressBar)
//       }
//       
//    func updateProgressBar() {
//        let action = SKAction.scaleX(to: progressValue, duration: 1.0)
//        progressBar.run(action)
//    }
//    
//       
//    func increaseProgress() {
//        // Calculate the distance between the player and the hole
//        let playerX = player.position.x
//        let holeX = holeSprite.position.x
//        let distance = max(0, holeX - playerX)
//
//        // Map the distance to a progress value between 0 and 1
//        let maxDistance = 40000  // Adjust this value based on your scene
//        progressValue = 1.0 - min(1.0, CGFloat(distance) / CGFloat(maxDistance))
//
//        // Update the progress bar
//        updateProgressBar()
//    }
//       
    
    func setupPhysics(){
        
        physicsWorld.contactDelegate = self
    }
    
    
    
    
    
    
    
    
    func createBG(){
        let backgroundImageSize = CGSize(width: 10000, height: 1500)
        

        for i in 0...2 {
            let backGround=SKSpriteNode(imageNamed: "Untitled_Artwork 6")
            
            backGround.anchorPoint = .zero
            
            
            
            backGround.position = CGPoint(x: CGFloat(i) * backgroundImageSize.width - backgroundImageSize.width / 2,
                                          y: -backgroundImageSize.height / 3)
            
            backGround.zPosition = -1.0
            backGround.name="Background"
            
            
            addChild(backGround)
           
            
        }
        setupHole()
        
    
        
        
    }
    func createBG2(){
        let backgroundImageSize = CGSize(width: 15000, height: 1500)
        
  
        for i in 0...2 {
            let backGround=SKSpriteNode(imageNamed: "fullBackground")
            
            backGround.anchorPoint = .zero
            
            
            
            backGround.position = CGPoint(x: CGFloat(i) * backgroundImageSize.width - backgroundImageSize.width / 10,
                                          y: -backgroundImageSize.height / 3)
            
            backGround.zPosition = -1.0
            backGround.name = "Background2\(i)"
            
            
            addChild(backGround)
           
            
        }
        
    
        
        
    }
    
    func createBG3(){
        let backgroundImageSize = CGSize(width: 10000, height: 1500)
        
  
        for i in 0...1 {
            let backGround=SKSpriteNode(imageNamed: "bg4")
            
            backGround.anchorPoint = .zero
            
            
            
            backGround.position = CGPoint(x: CGFloat(i) * backgroundImageSize.width - backgroundImageSize.width / 10,
                                          y: -backgroundImageSize.height / 3)
            
            backGround.zPosition = -1.0
            backGround.name = "Background3\(i)"
            
            
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

        player.position=CGPoint(x: 10, y: -160)
       
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

    // player.position=CGPoint(x: frame.width/2.0-100.0, y: ground.frame.height+player.frame.height/20.0)
//        player.position=CGPoint(x:frame.width/20.0-100.0, y: ground.frame.height+player.frame.height/20.0
    func setupCamera(){
        addChild(camerNode)
        camera=camerNode
        camerNode.position=CGPoint(x: frame.midX, y: frame.midY)
        
    }
    func moveCamera(){
        let amountToMove=CGPoint(x: cameraMovePointPerSecound*CGFloat(dt), y: 0.0)
        
//        camerNode.position=CGPoint(x: camerNode.position.x+amountToMove.x, y: camerNode.position.y+amountToMove.y)
        camerNode.position+=amountToMove
        
     //moving the ground inside of the camera

        
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
    func movePlayer(){
   
        let amountToMove=cameraMovePointPerSecound*CGFloat(dt)
        player.position.x += amountToMove
        
    }


    func setupHole(){
        
        // Third obstacle - Hole
      
        holeSprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: holeSprite.size.width, height: holeSprite.size.height ))
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
 // MARK: -   obstacle
    //obsticales
    func setupObsticales(){
        //first obstacle
        for i in 1...3{
            let sprite=SKSpriteNode(imageNamed: "block-\(i)")
            sprite.name="Block"
            sprite.setScale(0.85)
            sprite.physicsBody=SKPhysicsBody(rectangleOf: sprite.size)
            obstacle.append(sprite)
        }
        //second obstacle
        
        
        for _ in 1...2 {
            let sprite = SKSpriteNode(imageNamed: "obstacle-2")
            sprite.physicsBody = SKPhysicsBody(circleOfRadius: 0.90)
            sprite.name = "Obstacle"
            
            
            sprite.setScale(0.60)
            
            
            obstacle.append(sprite)
        }
        //snake
        // Load snake textures
        for i in 1...3 {
            let texture = SKTexture(imageNamed: "snake-\(i)")
            snakeTextures.append(texture)
            
            let snakeAnimation = SKAction.animate(with: snakeTextures, timePerFrame: 0.1)
            
            let  sprite = SKSpriteNode(texture: snakeTextures.first)
            sprite.name = "Snake"
            sprite.setScale(0.15)
            sprite.physicsBody = SKPhysicsBody(circleOfRadius: 0.50)
            
            sprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            sprite.zPosition = 5.0
            sprite.position = CGPoint(x: camera!.frame.maxX + sprite.frame.width / 2.0, y: -180)
            
            sprite.physicsBody?.affectedByGravity = false
            sprite.physicsBody?.isDynamic = false
            
            sprite.physicsBody?.categoryBitMask = PhysicsCategory.Obstacle
            sprite.physicsBody?.contactTestBitMask = PhysicsCategory.Player
            
            obstacle.append(sprite)
            
            sprite.run(.repeatForever(snakeAnimation))
            
        }
        
        
        
       
        
        
    
        
        //allow to add reandomly
        let index=Int(arc4random_uniform(UInt32(obstacle.count-1)))
        let sprite = obstacle[index].copy() as!SKSpriteNode
        sprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        sprite.zPosition=5.0
       
        sprite.position=CGPoint(x: cameraRec.maxX+sprite.frame.width/2.0, y:-200)
       
        sprite.physicsBody!.affectedByGravity = false
        sprite.physicsBody!.isDynamic = false
        if sprite.name == "Block" {
               sprite.physicsBody!.categoryBitMask = PhysicsCategory.Block
      
           } else {
               sprite.physicsBody!.categoryBitMask = PhysicsCategory.Obstacle
           }

           sprite.physicsBody!.contactTestBitMask = PhysicsCategory.Player

        
        addChild(sprite)
        sprite.run(.sequence([
         .wait(forDuration: 10.0),
         .removeFromParent()
        ]))
        
        
    }
    
    
    //here to loop and add obsticale forevere and the number from cg float
    func spawnObstacles(){
        let random = Double(CGFloat.random(min: 1.5, max: isTime))
        run(.repeatForever(.sequence([
            .wait(forDuration: random),
            .run {
                [weak self ] in
                self?.setupObsticales()
            }
        ])))
        run(.repeatForever(.sequence([.wait(
            forDuration: 5.0),
                                      .run {
                                          self.isTime -= 0.01
                                          if self.isTime <= 1.5{
                                              self.isTime=1.5
                                          }
                                      }
        
        ]
                                    )))
    }
    
   
    
    
    //coin
    func setupCoin(){
       coin = SKSpriteNode(imageNamed: "coin-1")
        let coinHight = coin.frame.height
        let random = CGFloat.random(min:-coinHight,max: coinHight*1.0)
        
        coin.position=CGPoint(x: cameraRec.maxX+coin.frame.width, y: size.height/6.0+random)
        coin.zPosition = 20.0
        coin.setScale(0.85)
        coin.name="Coin"
        coin.physicsBody=SKPhysicsBody(circleOfRadius: coin.size.width/2.0)
        coin.physicsBody!.affectedByGravity=false
        coin.physicsBody!.isDynamic=false
        coin.physicsBody!.categoryBitMask = PhysicsCategory.Coin
        coin.physicsBody!.contactTestBitMask = PhysicsCategory.Player
        
       // print(coin.frame)
        addChild(coin)
        coin.run(.sequence([.wait(forDuration: 15.0), .removeFromParent()
                           ]))
        var textures:[SKTexture] = []
        for i in 1 ... 6{
            textures.append(SKTexture(imageNamed: "coin-\(i)"))
        }
        coin.run(.repeatForever(.animate(with: textures, timePerFrame: 0.083)))
        
    }
    func spawnCoin(){
        
        let random = CGFloat.random(min: 2.5, max: 6.0)
        run(.repeatForever(.sequence([
            .wait(forDuration: random),
            .run {
                [weak self] in
                self?.setupCoin()
            }
        ])))
        
        
    }
    func setupLife(){
        
        let node1 = SKSpriteNode(imageNamed: "life-on")
        let node2 = SKSpriteNode(imageNamed: "life-on")
        let node3 = SKSpriteNode(imageNamed: "life-on")
        setupLifePos(node1, i: 1.0, j: 0.0)
        setupLifePos(node2, i: 2.0, j: 8.0)
        setupLifePos(node3, i: 3.0, j: 16.0)
        lifeNode.append(node1)
        lifeNode.append(node2)
        lifeNode.append(node3)
        
    }
    func setupLifePos(_ node:SKSpriteNode,i:CGFloat, j:CGFloat){
        let width = playableRect.width
        let height = playableRect.height
        node.setScale(0.050)
        node.zPosition = 50.0
        node.position = CGPoint(x: -width/2.0 + node.frame.width*i + j - 15.0,
                                y: height/2.0 - node.frame.height/2.0+380.0)

        //print(node.position)
        camerNode.addChild(node)
        
    }
    
    func setupScore(){
        //Icon
        coinIcon = SKSpriteNode(imageNamed: "coin-1")
        coinIcon.setScale(0.5)
        coinIcon.zPosition=50.0
        coinIcon.position = CGPoint(x: -playableRect.width/2.0 + coinIcon.frame.width, y: 
                                        playableRect.height/2.0 - lifeNode[0].frame.height/2.0+250)
        camerNode.addChild(coinIcon)
        //scoreLable
        scoreLable.text = "\(numScore)"
        scoreLable.fontSize = 60.0
        scoreLable.horizontalAlignmentMode = .left
        scoreLable.verticalAlignmentMode = .top
        scoreLable.zPosition = 50.0
        scoreLable.position=CGPoint(x: -playableRect.width/2.0+coinIcon.frame.width*2.0-10.0,y: coinIcon.position.y + coinIcon.frame.height/2.0 - 8.0)
        camerNode.addChild(scoreLable)
        
        

    }
    
    
    //setup Pause
    func setupPause(){
        pauseNode = SKSpriteNode(imageNamed: "pause")
        pauseNode.setScale(0.07)
        pauseNode.zPosition = 50.0
        pauseNode.name = "pause"
        pauseNode.position=CGPoint(x: playableRect.width/2.0 - pauseNode.frame.width/2.0 - 30.0,
                                   y: playableRect.height/2.0 - pauseNode.frame.height/2.0 + 380)
        camerNode.addChild(pauseNode)
    }
    //create panel
    
    func createPanel(){
        camerNode.addChild(containerNode)
        let panel = SKSpriteNode(imageNamed: "panel")
        panel.zPosition=60.0
        panel.setScale(0.4)
        panel.position = .zero
        containerNode.addChild(panel)
        
        //
        let resume = SKSpriteNode(imageNamed: "resume")
        resume.zPosition = 70.0
        resume.name = "resume"
        resume.setScale(0.28)
        resume.position=CGPoint(x: -panel.frame.width/2.0+resume.frame.width*1.5,
                                y: 0.0)
        panel.addChild(resume)
        
        //
        let quit = SKSpriteNode(imageNamed: "back")
        quit.zPosition = 70.0
        quit.name = "quit"
        quit.setScale(0.28)
        quit.position=CGPoint(x: panel.frame.width/2.0-quit.frame.width*1.5,
                                y: 0.0)
        panel.addChild(quit)
        
        
        
    }
    
    //MARK: - BOUNDERY IN OUR CASE IT'S NAMED بير
    func bounCheckPlayer(){
        let bottomLeft = CGPoint(x: cameraRec.minX, y: cameraRec.minY)
        if player.position.x <= bottomLeft.x{
            player.position.x = bottomLeft.x
            lifeNode.forEach({$0.texture = SKTexture(imageNamed: "life-off")})
            numScore = 0
            scoreLable.text = "\(numScore)"
            gameOver = true
        }
    }
    
    
    ///setup GameOver
    func setupGameOver(){
        life -= 1
        if life <= 0{ life = 0 }
        lifeNode[life].texture = SKTexture(imageNamed: "life-off")
        
        if life <= 0 && !gameOver{
            gameOver = true
        }
    }
    
    func showGameOverOverlay() {
            // Create a semi-transparent overlay node
            let overlay = SKSpriteNode(color: SKColor.black, size: self.size)
            overlay.alpha = 0.5  // Adjust the alpha to control the darkness

            // Position the overlay in the center
            overlay.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)

            // Add the overlay as a child of the scene
            self.addChild(overlay)

          
            gameOver = false
        }
    
    
    

}
// MARK: - Sk

extension GameScene:SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        let other = contact.bodyA.categoryBitMask == PhysicsCategory.Player ? contact.bodyB :contact.bodyA
        switch other.categoryBitMask {
        case PhysicsCategory.Block:
            //increae the speed of tyhe camera
            cameraMovePointPerSecound += 150.0
            //numScore -= 1
            if numScore <= 0 {numScore=0}
            scoreLable.text = "\(numScore)"
            run(soundCollison)
            //soundPlayer.playSound(named: "collision", fileType: "wav")
            print("Block")
            
        case PhysicsCategory.Obstacle:
            print("Obstacle")
            setupGameOver()
            
            
            print("Game Over")
        case PhysicsCategory.Hole:
            // Player collided with the hole, remove the player
          //  player.removeFromParent()
            
            // Player collided with the hole, remove the player
                       player.removeFromParent()
     
            run(soundHole)
                       // Delay for 3 seconds
            let delayAction = SKAction.wait(forDuration: 0.7)

                       let transitionAction = SKAction.run {
                           let scene =  NextStage(size: self.size)
                           scene.scaleMode = self.scaleMode
                           scene.size = CGSize(width: 2048, height: 1536)
                           self.view?.presentScene(scene, transition: .doorsCloseHorizontal(withDuration: 0.2))
                       }

                       // Run the sequence
                       self.run(SKAction.sequence([delayAction, transitionAction]))
            
            
        case PhysicsCategory.Coin:
            if let node=other.node{
                print("Coin")
                node.removeFromParent()
                numScore += 1
                scoreLable.text = "\(numScore)"
              
                UserDefaults.standard.set(numScore, forKey: "KeyScore")
                
                //increaseProgress()
                if numScore % 5 == 0 {
                    cameraMovePointPerSecound += 150.0
                }
                
                //score
                let highscore = ScoreGenerator.sharedInstance.getHighscore()
                if numScore > highscore{
                    ScoreGenerator.sharedInstance.setHighscore(numScore)
                    ScoreGenerator.sharedInstance.setScore(highscore)
                    //numScore
                    
                    
                }
                //soundPlayer.playSound(named: "coin", fileType: "mp3")
                    run(soundCoin)
            }
           
        default :break
            
        }
    }
}
