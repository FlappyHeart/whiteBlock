//
//  GameScene.swift
//  pancake
//
//  Created by Alfred on 14-10-9.
//  Copyright (c) 2014年 HackSpace. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var numberOfGroup = 5
    
    var enemyTexture = SKTexture(imageNamed: "enemy")
    var houseTexture = SKTexture(imageNamed: "house")
    var eggTexture = SKTexture(imageNamed: "egg")
    var backgroundTexture = SKTexture(imageNamed: "background")
    
    var enemy:SKSpriteNode!
    var enemyGroup = NSMutableArray()
    var egg:SKSpriteNode!
    var eggGroup = NSMutableArray()
    
    var rects = SKNode()
    var eggs = SKNode()
    
    var currentIndex = 0
    var score = 0
    var timeCounter = 20
    
    
    var userDefault = UserDefaults.standard
    
    var sceneZero:CGPoint!
    var enemyWidth:CGFloat!
    var enemyHeight:CGFloat!
    
    var scoreLabel:SKLabelNode!
    var timerLabel:SKLabelNode!
    
    var hitSound = SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: false)
    var failSound = SKAction.playSoundFileNamed("fail.wav", waitForCompletion: false)
    
    var moveABit:SKAction!
    var fadeOut:SKAction!
    
    override func didMove(to view: SKView) {
        //some useful constants
        enemyWidth = enemyTexture.size().width
        enemyHeight = enemyTexture.size().height
        moveABit = SKAction.move(by: CGVector(dx: 0, dy: -self.enemyHeight), duration: 0.1)
        fadeOut = SKAction.sequence([SKAction.fadeOut(withDuration: 0.3),SKAction.removeFromParent()])
        
        let temp = self.frame.width * 0.5 - enemyWidth * 2.5
        sceneZero = CGPoint(x: temp, y: self.frame.height * 0.33)
        
        //init HUD
        scoreLabel = SKLabelNode()
        scoreLabel.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.9)
        scoreLabel.fontColor = .black
        scoreLabel.fontName = "Gasalt-Black"
        scoreLabel.fontSize = 52
        scoreLabel.zPosition = 5
        scoreLabel.text = "\(score)"
        
        self.addChild(scoreLabel)
        
        timerLabel = SKLabelNode()
        timerLabel.position = CGPoint(x: self.frame.width * 0.65, y: self.frame.height * 0.9)
        timerLabel.fontColor = .black
        timerLabel.fontName = "Gasalt-Black"
        timerLabel.fontSize = 52
        timerLabel.zPosition = 5
        timerLabel.text = "\(timeCounter)"
        
        self.addChild(timerLabel)
        timerLabel.run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 1.0),SKAction.run({
            if self.timeCounter > 0{
                self.timeCounter -= 1
                self.timerLabel.text = "\(self.timeCounter)"
            }else{
                self.gameOver()
                self.timerLabel.removeAllActions()
            }
            
        
        })])))
        
        let background = SKSpriteNode(texture: backgroundTexture)
//        background.anchorPoint = CGPointZero
        background.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
        self.addChild(background)
        
        for i in 0...numberOfGroup {
            enemy = SKSpriteNode(texture: enemyTexture)
            enemyGroup.add(enemy)
            
            rects.addChild(enemy)
            enemy.position = CGPoint(x: randomPointX(), y: enemyHeight * CGFloat(i))
            
            egg = SKSpriteNode(texture: eggTexture)
            eggGroup.add(egg)
        }
        
        rects.position = sceneZero
        self.addChild(rects)
        eggs.position = CGPoint(x: 0, y: 0)
        eggs.zPosition = 5
        self.addChild(eggs)
        
        let house = SKSpriteNode(texture: houseTexture)
        house.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.12)
        self.addChild(house)
        
        /* Setup your scene here */
        self.backgroundColor = .gray
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            /* Called when a touch begins */
    //        let _:CGPoint! = (touches.first) as AnyObject as! CGPoint;).location(in view: self)
            
    //        for touch: AnyObject in touches {
        let location:CGPoint! = (touches.first as AnyObject).location(in: self)
        if location.y > sceneZero.y + enemyHeight * 0.5{
            return
        }
        let touch = location
        
//        location.x -= rects.position.x
//        location.y -= rects.position.y
        
        let enemyTmp = enemyGroup.object(at: currentIndex) as! SKSpriteNode
        
        if enemyTmp.contains(location){
            self.run(hitSound)
            
            let egg = eggGroup.object(at: currentIndex) as! SKSpriteNode
            egg.alpha = 1
            egg.position = touch ?? CGPoint(x: 0, y: 0)
            egg.run(fadeOut)
            eggs.addChild(egg)
            
            score += 1
            scoreLabel.text = "\(score)"
            
            enemyTmp.position.y += enemyHeight * CGFloat(numberOfGroup)
            enemyTmp.position.x = randomPointX()
            
            for child in enemyGroup{
                (child as AnyObject).run(self.moveABit)
            }
            
            currentIndex += 1
            if currentIndex == numberOfGroup{
                currentIndex = 0
            }
        }else{
            gameOver()
        }

    }
    
    func gameOver(){
        totalScore = score
        self.isUserInteractionEnabled = false
        run(SKAction.sequence([failSound,SKAction.run({
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "gameOverNotification"), object: nil)
        })]))
    }
   
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func randomPointX()->CGFloat{
        return CGFloat((arc4random() % 4)) * enemyWidth
    }
    
}
