//
//  GameViewController.swift
//  CrappyBirds
//
//  Created by Daniel Hauagge on 3/19/16.
//  Copyright (c) 2016 Daniel Hauagge. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var rankListButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var scoreDisplayView: UIView!
    
    var skView : SKView!
    let scoreDisplayer = ScoreDisplay()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsPhysics = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
        // bring the buttons to the front
        self.view.bringSubviewToFront(restartButton)
        self.view.bringSubviewToFront(playButton)
        self.view.bringSubviewToFront(rankListButton)
        self.view.bringSubviewToFront(settingsButton)
        self.view.bringSubviewToFront(pauseButton)
        
        // set the score display area
        scoreDisplayer.setTargetForDisplay(scoreDisplayView)
        
        // pause the game at the beginning
        skView.paused = true
        showButtonsAnimation()
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func restartButtonClicked(sender: UIButton) {
        
    }
    
    @IBAction func playButtonClicked(sender: UIButton) {
        // un-pause the game
        if skView.paused {
            skView.paused = false
        }
        // hide other buttons and show pause button
        hideButtonsAnimation()
        // show score
        scoreDisplayer.displayAnyScore(123456789)
    }
    
    @IBAction func rankListButtonClicked(sender: UIButton) {
        
    }
    
    @IBAction func settingsButtonClicked(sender: UIButton) {
        
    }
    
    @IBAction func pauseButtonClicked(sender: UIButton) {
        // pause the game
        skView.paused = true
        showButtonsAnimation()
    }
    
    func hideButtonsAnimation() {
        // show the pause button
        pauseButton.transform = CGAffineTransformMakeScale(0.1, 0.1)
        pauseButton.hidden = false
        
        // animation with buttons
        UIView.animateWithDuration(1.0,
            delay: 0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .AllowUserInteraction,
            animations: {
                self.rankListButton.transform = CGAffineTransformMakeScale(0.001, 0.001)
                self.settingsButton.transform = CGAffineTransformMakeScale(0.001, 0.001)
                self.restartButton.transform = CGAffineTransformMakeScale(0.001, 0.001)
                self.playButton.transform = CGAffineTransformMakeScale(0.001, 0.001)
                self.pauseButton.transform = CGAffineTransformIdentity
            }, completion: {finished in
                // hide other buttons
                self.rankListButton.hidden = true
                self.settingsButton.hidden = true
                self.restartButton.hidden = true
                self.playButton.hidden = true
        })
    }
    
    func showButtonsAnimation() {
        
        // show the pause button
        self.rankListButton.transform = CGAffineTransformMakeScale(0.1, 0.1)
        self.settingsButton.transform = CGAffineTransformMakeScale(0.1, 0.1)
        self.restartButton.transform = CGAffineTransformMakeScale(0.1, 0.1)
        self.playButton.transform = CGAffineTransformMakeScale(0.1, 0.1)
        // show other buttons
        rankListButton.hidden = false
        settingsButton.hidden = false
        restartButton.hidden = false
        playButton.hidden = false
        
        // animation with buttons
        UIView.animateWithDuration(1.0,
            delay: 0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .AllowUserInteraction,
            animations: {
                self.pauseButton.transform = CGAffineTransformMakeScale(0.001, 0.001)
                self.rankListButton.transform = CGAffineTransformIdentity
                self.settingsButton.transform = CGAffineTransformIdentity
                self.restartButton.transform = CGAffineTransformIdentity
                self.playButton.transform = CGAffineTransformIdentity
            }, completion: {finished in
                // hide other buttons
                self.pauseButton.hidden = true
        })
    }
}