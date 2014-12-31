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
    
    
    var userDefault = NSUserDefaults.standardUserDefaults()
    
    var sceneZero:CGPoint!
    var enemyWidth:CGFloat!
    var enemyHeight:CGFloat!
    
    var scoreLabel:SKLabelNode!
    var timerLabel:SKLabelNode!
    
    var hitSound = SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: false)
    var failSound = SKAction.playSoundFileNamed("fail.wav", waitForCompletion: false)
    
    var moveABit:SKAction!
    var fadeOut:SKAction!
    
    override func didMoveToView(view: SKView) {
        //some useful constants
        enemyWidth = enemyTexture.size().width
        enemyHeight = enemyTexture.size().height
        moveABit = SKAction.moveBy(CGVectorMake(0, -self.enemyHeight), duration: 0.1)
        fadeOut = SKAction.sequence([SKAction.fadeOutWithDuration(0.3),SKAction.removeFromParent()])
        
        sceneZero = CGPointMake(self.frame.width * 0.5 - enemyWidth * 2 + enemyWidth * 0.5, self.frame.height * 0.33)
        
        //init HUD
        scoreLabel = SKLabelNode()
        scoreLabel.position = CGPointMake(self.frame.width * 0.5, self.frame.height * 0.9)
        scoreLabel.fontColor = SKColor.blackColor()
        scoreLabel.fontName = "Gasalt-Black"
        scoreLabel.fontSize = 52
        scoreLabel.zPosition = 5
        scoreLabel.text = "\(score)"
        
        self.addChild(scoreLabel)
        
        timerLabel = SKLabelNode()
        timerLabel.position = CGPointMake(self.frame.width * 0.65, self.frame.height * 0.9)
        timerLabel.fontColor = SKColor.blackColor()
        timerLabel.fontName = "Gasalt-Black"
        timerLabel.fontSize = 52
        timerLabel.zPosition = 5
        timerLabel.text = "\(timeCounter)"
        
        self.addChild(timerLabel)
        timerLabel.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.waitForDuration(1.0),SKAction.runBlock({
            if self.timeCounter > 0{
                self.timeCounter--
                self.timerLabel.text = "\(self.timeCounter)"
            }else{
                self.gameOver()
                self.timerLabel.removeAllActions()
            }
            
        
        })])))
        
        var background = SKSpriteNode(texture: backgroundTexture)
//        background.anchorPoint = CGPointZero
        background.position = CGPointMake(self.frame.width * 0.5, self.frame.height * 0.5)
        self.addChild(background)
        
        for var i = 0; i < numberOfGroup; i++ {
            enemy = SKSpriteNode(texture: enemyTexture)
            enemyGroup.addObject(enemy)
            
            rects.addChild(enemy)
            enemy.position = CGPointMake(randomPointX(), enemyHeight * CGFloat(i))
            
            egg = SKSpriteNode(texture: eggTexture)
            eggGroup.addObject(egg)
        }
        
        rects.position = sceneZero
        self.addChild(rects)
        eggs.position = CGPointMake(0, 0)
        eggs.zPosition = 5
        self.addChild(eggs)
        
        var house = SKSpriteNode(texture: houseTexture)
        house.position = CGPointMake(self.frame.width * 0.5, self.frame.height * 0.12)
        self.addChild(house)
        
        /* Setup your scene here */
        self.backgroundColor = SKColor.grayColor()
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        var location:CGPoint! = touches.anyObject()?.locationInNode(self)
        if location.y > sceneZero.y + enemyHeight * 0.5{
            return
        }
        var touch = location
        
        location.x -= rects.position.x
        location.y -= rects.position.y
        
        var enemyTmp = enemyGroup.objectAtIndex(currentIndex) as SKSpriteNode
        
        if enemyTmp.containsPoint(location){
            self.runAction(hitSound)
            
            var egg = eggGroup.objectAtIndex(currentIndex) as SKSpriteNode
            egg.alpha = 1
            egg.position = touch
            egg.runAction(fadeOut)
            eggs.addChild(egg)
            
            score++
            scoreLabel.text = "\(score)"
            
            enemyTmp.position.y += enemyHeight * CGFloat(numberOfGroup)
            enemyTmp.position.x = randomPointX()
            
            for child in enemyGroup{
                child.runAction(self.moveABit)
            }
            
            currentIndex++
            if currentIndex == numberOfGroup{
                currentIndex = 0
            }
        }else{
            gameOver()
        }

    }
    
    func gameOver(){
        totalScore = score
        self.userInteractionEnabled = false
        self.runAction(SKAction.sequence([failSound,SKAction.runBlock({
            NSNotificationCenter.defaultCenter().postNotificationName("gameOverNotification", object: nil)
        })]))
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func randomPointX()->CGFloat{
        return CGFloat((arc4random() % 4)) * enemyWidth
    }
    
}
