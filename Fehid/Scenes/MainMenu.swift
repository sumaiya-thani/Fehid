//
//  MainMenu.swift
//  GameChallange
//
//  Created by sumaiya on 20/12/2566 BE.
//
import SpriteKit
import GameplayKit

class MainMenu:SKScene{
    
   

    //MARK: -Properties
    
    var containerNode:SKSpriteNode!
    //MARK: -System
    override func didMove(to view: SKView) {
        
        // Set a fixed size or calculate it based on the device's screen size
              let fixedSize = CGSize(width: 2048, height: 1536) // Set your desired width and height

              // Set the scene size
              self.size = fixedSize
        
        setupBG()
        setupNodes()

    }
    //scene.scaleMode = scaleMode
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        
        
//        guard let touch = touches.first else {return}
//        let node = atPoint(touch.location(in: self))
//        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
//
//        print("Touched node name: \(node.name ?? "nil")")
//        print("Touched node position: \(node.position)")
        
        if node.name == "play"{
            
            let scene = GameScene(size: size)
            scene.scaleMode = .aspectFill
    
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
          
    view!.presentScene(scene)
            
            
            
            
        }else if node.name == "highscore"{
            setupPanel()
        }else if node.name == "setting"{
            setupSetting()
            
        }else if node.name == "container"{
            containerNode.removeFromParent()
            
        }else if node.name == "music"{
            let node = node as! SKSpriteNode
            SKTAudio.musicEnabled = !SKTAudio.musicEnabled
            node.texture = SKTexture(imageNamed: SKTAudio.musicEnabled ? "musicOn" : "musicOff")
        }else if node.name == "effect"{
            let node = node as! SKSpriteNode
            effectEnabled = !effectEnabled
            node.texture = SKTexture(imageNamed: effectEnabled ? "effectOn" : "effectOff")
        }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
       moveGrounds()
    }
    
}

//MARK: - Configurations

extension MainMenu{
    

    
    
    func setupBG() {
            let bgNode = SKSpriteNode(imageNamed: "menu")
      
            bgNode.zPosition = -1.0
        bgNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        // Set the size based on the aspect ratio
           let aspectRatio = bgNode.size.width / bgNode.size.height
           bgNode.size = CGSize(width: self.size.width - 12, height: self.size.width / aspectRatio - 80 )

           // Set the position to the center of the scene
           bgNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)


            addChild(bgNode)
        
    }
    
   
    
    
    func moveGrounds(){
        enumerateChildNodes(withName: "ground"){(node, _) in
            let node = node as! SKSpriteNode
            node.position.x -= 8.0
            if node.position.x < -self.frame.width{
                node.position.x += node.frame.width*2.0
            }
            
        }
        
    }
    
    ///the three button
    func setupNodes(){
        let play = SKSpriteNode(imageNamed: "play")
        play.name="play"
        play.setScale(0.14)
        play.zPosition = 20.0
        play.position = CGPoint(x: size.width/2.0 + 360 , y: 800 )
       
        //print(play.position.y)
        addChild(play)
        
        let highScore = SKSpriteNode(imageNamed: "highscore")
        highScore.name="highscore"
     
        highScore.setScale(0.14)
        highScore.zPosition = 20.0
        highScore.position = CGPoint(x: size.width/2.0 + 360 , y: 650)
       
        addChild(highScore)
        
        let setting = SKSpriteNode(imageNamed: "setting")
        setting.name="setting"

        setting.setScale(0.14)
        setting.zPosition = 20.0
        setting.position = CGPoint(x: size.width/2.0 + 360 , y: 500)

        addChild(setting)
        
        
        
        
        
        
        
    }
    
    
    func setupPanel(){
        setupContainer()
        
        
        let panel = SKSpriteNode(imageNamed: "panel")
        panel.setScale(0.5)
        panel.zPosition = 20.0
        panel.position = .zero
        containerNode.addChild(panel
        )
        //HighScore
        let x = -panel.frame.width/2.0 + 250.0
        let highscoreLbl = SKLabelNode()
       // highscoreLbl.text = "HighScore: \(ScoreGenerator.sharedInstance.getHighscore())"
        highscoreLbl.text = NSLocalizedString(" High Score : \(ScoreGenerator.sharedInstance.getHighscore()) ",  comment: "")
        highscoreLbl.horizontalAlignmentMode = .left
        highscoreLbl.fontSize = 80.0
        highscoreLbl.zPosition = 25.0
        highscoreLbl.position = CGPoint(x: x, y: highscoreLbl.frame.height/2.0 - 30.0)
        panel.addChild(highscoreLbl)
        
        //
     
        let scoreLbl = SKLabelNode()
        scoreLbl.text = "Score : \(ScoreGenerator.sharedInstance.getScore())"
        scoreLbl.horizontalAlignmentMode = .left
        scoreLbl.fontSize = 80.0
        scoreLbl.zPosition = 25.0
        scoreLbl.position = CGPoint(x: x, y: -scoreLbl.frame.height/2.0 - 30.0)
        panel.addChild(scoreLbl)
        
        
    
        
    }
    func setupContainer(){
        containerNode = SKSpriteNode()
        containerNode.name="container"
        containerNode.zPosition = 15.0
        containerNode.color = .clear
        containerNode.size = size
        containerNode.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
        addChild(containerNode)
        
    }

    func setupSetting(){
        setupContainer()
        
        //Panel
        
        let panel = SKSpriteNode(imageNamed: "panel")
        panel.setScale(0.50)
        panel.zPosition = 25.0
        panel.position = .zero
        containerNode.addChild(panel)
        
        
        
        //Music
        
        let music = SKSpriteNode(imageNamed: SKTAudio.musicEnabled ? "musicOn":"musicOff")
        music.name = "music"
        music.setScale(0.20)
        music.zPosition = 25.0
        music.position = CGPoint(x: -music.frame.width - 50.0, y: 0.0)
        panel.addChild(music)

        //Sound
        
        let effect = SKSpriteNode(imageNamed:effectEnabled ? "effectOn" : "effectOff")
        effect.name = "effect"
        effect.setScale(0.20)
        effect.zPosition = 25.0
        effect.position = CGPoint(x: music.frame.width + 50.0, y: 0.0)
        panel.addChild(effect)
        
        
    }

    
    
    
}
