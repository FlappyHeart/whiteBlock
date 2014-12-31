//
//  GameViewController.swift
//  pancake
//
//  Created by Alfred on 14-10-9.
//  Copyright (c) 2014年 HackSpace. All rights reserved.
//

import UIKit
import SpriteKit


var totalScore = 0
var bestScore = 0


class GameViewController: UIViewController {
    
    @IBOutlet weak var gameOverView: UIView!
    @IBOutlet weak var gamePauseView: UIView!
    @IBOutlet weak var pause: UIButton!

    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    
    var userDefault = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bestScore = userDefault.integerForKey("bestScore")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gameOver", name: "gameOverNotification", object: nil)
        

        var scene = GameScene(size: CGSizeMake(1024, 768))
        // Configure the view.
        let skView = self.view as SKView
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
        
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func pauseGame(sender: UIButton) {
        var skView = self.view as SKView
        if sender.titleLabel?.text == "暂停"{
            sender.setTitle("继续", forState: UIControlState.Normal)
            skView.paused = true
            skView.scene?.userInteractionEnabled = false
        }else{
            sender.setTitle("暂停", forState: UIControlState.Normal)
            skView.paused = false
            skView.scene?.userInteractionEnabled = true
        }
        
        
    }
    
    func gameOver(){
        gamePauseView.hidden = true
        gameOverView.hidden = false
        
        if totalScore > bestScore{
            userDefault.setInteger(totalScore, forKey: "bestScore")
            userDefault.synchronize()
            bestScore = totalScore
        }
        
        totalScoreLabel.text = "本轮击退：\(totalScore) 个"
        bestScoreLabel.text = "个人记录：\(bestScore) 个"
        
    }
    
    @IBAction func restartGame(sender: UIButton) {
        gameOverView.hidden = true
        gamePauseView.hidden = false
    
        
        var scene = GameScene(size: CGSizeMake(1024, 768))
        // Configure the view.
        let skView = self.view as SKView
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
        
    }
    
    @IBAction func share(sender: UIButton) {
        //share game
    }
}
