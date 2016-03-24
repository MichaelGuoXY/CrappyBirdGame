//
//  RankTableViewController.swift
//  CrappyBirds
//
//  Created by Guo Xiaoyu on 3/22/16.
//  Copyright © 2016 Daniel Hauagge. All rights reserved.
//

import UIKit

class RankTableViewController: UITableViewController {

    @IBAction func backButtonClicked(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    var numOfPlayers = UInt(10)
    var numOfSections = 0
    var playerArray = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // set tableview background image
        tableView.backgroundView = UIImageView(image: UIImage(named: "rankbgd"))
        PlayersInfoManager.fetchPlayerInfoWithCapacity(numOfPlayers, reloadTableView: reloadTableView)
    }

    func reloadTableView(playersArray : [NSDictionary]) {
        // reverse playersArray to let it order from larger to smaller
        self.playerArray = playersArray.reverse()
        // set numOfSections
        numOfSections = Int(numOfPlayers)
        // tableview reload data
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return numOfSections
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.backgroundColor = UIColor.clearColor()
        view.tintColor = UIColor.clearColor()
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = UIColor.clearColor()
        view.tintColor = UIColor.clearColor()
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        return 5
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseIdentifier = "RankTableCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! RankTableViewCell

        // Configure the cell...
        cell.layer.cornerRadius = 20;
        cell.layer.borderColor = UIColor.clearColor().CGColor
        cell.layer.borderWidth = 1.2;

        let playerDict = playerArray[indexPath.section]
        let playerName = playerDict["name"] as! String
        let playerScore = playerDict["score"] as! NSNumber
        let playerUniversity = playerDict["university"] as! String
        cell.nameLabel.text = playerName
        cell.scoreLabel.text = "Score: \(Int(playerScore))"
        cell.universityLabel.text = playerUniversity
        
        // set the medal image for each cell
        
        if indexPath.section == 0 {
            cell.medalImageView?.image = UIImage.init(named: "No1")
        }
        else if indexPath.section == 1 {
            cell.medalImageView?.image = UIImage.init(named: "No2")
        }
        else if indexPath.section == 2 {
            cell.medalImageView?.image = UIImage.init(named: "No3")
        }
        else {
            cell.medalImageView?.image = UIImage.init(named: "No4")
//            let imageMaskView = UIView.init(frame: (cell.imageView?.frame)!)
//            imageMaskView.backgroundColor = UIColor.clearColor()
//            cell.contentView.addSubview(imageMaskView)
//            cell.contentView.bringSubviewToFront(imageMaskView)
            let displayScoreObj = ScoreDisplay()
            displayScoreObj.setTargetForDisplay(cell.medalImageView)
            displayScoreObj.displayAnyScore(indexPath.section + 1)
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
