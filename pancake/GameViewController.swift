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
    
    var userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bestScore = userDefault.integer(forKey: "bestScore")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.gameOver), name: NSNotification.Name(rawValue: "gameOverNotification"), object: nil)
        

        let scene = GameScene(size: CGSize(width: 1024, height: 768))
        // Configure the view.
        let skView = self.view as! SKView
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .aspectFill
        
        skView.presentScene(scene)
        
    }

    override var shouldAutorotate: Bool {
           return true
       }

       override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
           if UIDevice.current.userInterfaceIdiom == .phone {
               return .allButUpsideDown
           } else {
               return .all
           }
       }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    @IBAction func pauseGame(sender: UIButton) {
        let skView = self.view as! SKView
        if sender.titleLabel?.text == "暂停"{
            sender.setTitle("继续", for: .normal)
            skView.isPaused = true
            skView.scene?.isUserInteractionEnabled = false
        }else{
            sender.setTitle("暂停", for: .normal)
            skView.isPaused = false
            skView.scene?.isUserInteractionEnabled = true
        }
        
        
    }
    
    @objc func gameOver(){
        gamePauseView.isHidden = true
        gameOverView.isHidden = false
        
        if totalScore > bestScore{
            userDefault.set(totalScore, forKey: "bestScore")
            userDefault.synchronize()
            bestScore = totalScore
        }
        
        totalScoreLabel.text = "本轮击退：\(totalScore) 个"
        bestScoreLabel.text = "个人记录：\(bestScore) 个"
        
    }
    
    @IBAction func restartGame(sender: UIButton) {
        gameOverView.isHidden = true
        gamePauseView.isHidden = false
    
        
        let scene = GameScene(size: CGSize(width: 1024, height: 768))
        // Configure the view.
        let skView = self.view as! SKView
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .aspectFill
        
        skView.presentScene(scene)
        
    }
    
    @IBAction func share(sender: UIButton) {
        //share game
    }
}
