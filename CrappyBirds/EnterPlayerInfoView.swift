//
//  EnterPlayerInfoView.swift
//  CrappyBirds
//
//  Created by Guo Xiaoyu on 3/22/16.
//  Copyright © 2016 Daniel Hauagge. All rights reserved.
//

import UIKit

@IBDesignable class EnterPlayerInfoView: UIView {
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    // Our custom view from the XIB file
    var view: UIView!
    var parentViewController : GameViewController!
    var score : Int!
    var nameValid : Bool!
    var universityValid : Bool!
    var scoreDisplayer = ScoreDisplay()
    
    @IBOutlet weak var scoreDisplayView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var displayScoreLabel: UILabel!
    @IBOutlet weak var enterNameTextField: UITextField!
    @IBAction func universityEditing(sender: UITextField) {
        if sender.text != "" {
            universityValid = true
        }
        else {
            universityValid = false
        }
        
        if (nameValid == true) && (universityValid == true){
            submitButton.enabled = true
        }
    }
    @IBAction func nameEditing(sender: UITextField) {
        if sender.text != "" {
            nameValid = true
        }
        else {
            universityValid = false
        }
        
        if (nameValid == true) && (universityValid == true) {
            submitButton.enabled = true
        }
    }
    
    @IBOutlet weak var enterUniversityTextField: UITextField!
    
    func viewWillShowUp(score : Int) {
        // show itself
        self.hidden = false
        // show score
        self.score = score
        scoreDisplayer.setTargetForDisplay(scoreDisplayView)
        scoreDisplayer.displayAnyScore(score)
        // reset text field
        enterNameTextField.text = ""
        enterUniversityTextField.text = ""
        // disable submit button
        universityValid = false
        nameValid = false
        submitButton.enabled = false
    }
    
    func setsParentViewController(viewContorller : UIViewController) {
        parentViewController = viewContorller as! GameViewController
    }
    
    @IBAction func quitButtonClicked(sender: UIButton) {
        // do nothing
        
        // hide itself
        self.hidden = true
        // show buttons
        parentViewController.showButtonsAnimation(false)
    }
    @IBAction func submitButtonClicked(sender: UIButton) {
        // do something
        PlayersInfoManager.savePlayerInfo(enterNameTextField.text!, university: enterUniversityTextField.text!, score: score)
        // hide itself
        self.hidden = true
        // show buttons
        parentViewController.showButtonsAnimation(false)
    }
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        enterNameTextField.resignFirstResponder()
        enterUniversityTextField.resignFirstResponder()
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "EnterPlayerInfoView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
}
