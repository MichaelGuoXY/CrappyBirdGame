//
//  ScoreDisplay.swift
//  CrappyBirds
//
//  Created by Guo Xiaoyu on 3/21/16.
//  Copyright © 2016 Daniel Hauagge. All rights reserved.
//

import UIKit

class ScoreDisplay: NSObject {
    var numOfDigits = Int(0)
    var startScore = Int(0)
    var nowScore = Int(0)
    var displayView : UIView!
    var displayFrame : CGRect!
    var ints = [Int]()
    var frames = [CGRect]()
    var imageWidth : CGFloat!
    var imageHeight : CGFloat!
    var oddNumCentreTopX : CGFloat!
    var oddNumCentreTopY : CGFloat!
    var evenNumCentreTopX : CGFloat!
    var evenNumCentreTopY : CGFloat!
    
    // must init
    func setTargetForDisplay(contentView : UIView) {
        displayView = contentView
        displayFrame = contentView.bounds
        imageHeight = displayFrame.height
        imageWidth = imageHeight / 1.9
        oddNumCentreTopX = displayFrame.origin.x + displayFrame.width / 2 - imageWidth / 2
        oddNumCentreTopY = displayFrame.origin.y
        evenNumCentreTopX = displayFrame.origin.x + displayFrame.width / 2
        evenNumCentreTopY = displayFrame.origin.y
    }
    
    // change start score
    func changeStartScore(startingScore : Int) {
        startScore = startingScore
    }
    
    // change now score
    func changeNowScore(nowingScore : Int) {
        nowScore = nowingScore
    }
    
    // display start score
    func displayStartScore() {
        
    }
    
    // obtain numbers of digits in such score
    func getNumOfDigits(score : Int) -> Int{
        var tmp = score
        var count = 1
        while tmp / 10 > 0 {
            tmp /= 10
            count++
        }
        return count
    }
    
    // display any score you want
    func displayAnyScore(score : Int) {
        processScore(score)
        processFrames(score)
        let count = getNumOfDigits(score)
        for i in 0..<count {
            let number = ints[i]
            let frame = frames[i]
            displayNumberImgAtFrame(number, frame: frame)
        }
    }
    
    func processScore(var score : Int) {
        ints = []
        let count = getNumOfDigits(score)
        for _ in 0..<count {
            let lastDigit = score % 10
            ints.append(lastDigit)
            score /= 10
        }
        ints = ints.reverse()
    }
    
    func processFrames(score : Int) {
        frames = []
        let count = getNumOfDigits(score)
        // if count is odd number
        if count % 2 == 1 {
            let halfCount = (count - 1) / 2
            // before
            for i in 0..<halfCount {
                let x = oddNumCentreTopX - CGFloat(halfCount - i) * imageWidth
                let y = oddNumCentreTopY
                let frame = CGRectMake(x, y, imageWidth, imageHeight)
                frames.append(frame)
            }
            // mid
            let midFrame = CGRectMake(oddNumCentreTopX, oddNumCentreTopY, imageWidth, imageHeight)
            frames.append(midFrame)
            // after
            for i in 1..<halfCount+1 {
                let x = oddNumCentreTopX + CGFloat(i) * imageWidth
                let y = oddNumCentreTopY
                let frame = CGRectMake(x, y, imageWidth, imageHeight)
                frames.append(frame)
            }
        }
        // if count is even number
        else {
            let halfCount = count / 2
            // before
            for i in 0..<halfCount {
                let x = evenNumCentreTopX - CGFloat(halfCount - i) * imageWidth
                let y = evenNumCentreTopY
                let frame = CGRectMake(x, y, imageWidth, imageHeight)
                frames.append(frame)
            }
            // at
            let midFrame = CGRectMake(evenNumCentreTopX, evenNumCentreTopY, imageWidth, imageHeight)
            frames.append(midFrame)
            // after
            for i in 1..<halfCount {
                let x = evenNumCentreTopX + CGFloat(i) * imageWidth
                let y = evenNumCentreTopY
                let frame = CGRectMake(x, y, imageWidth, imageHeight)
                frames.append(frame)
            }
        }
    }
    
    // display number image at certain frame
    func displayNumberImgAtFrame(number : Int, frame : CGRect) {
        let imgName = "\(number).png"
        let image = UIImage(named: imgName)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .ScaleAspectFit
        imageView.frame = frame
        displayView.addSubview(imageView)
    }
}
