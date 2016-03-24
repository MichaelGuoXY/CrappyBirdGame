//
//  PlayersInfoManager.swift
//  CrappyBirds
//
//  Created by Guo Xiaoyu on 3/22/16.
//  Copyright © 2016 Daniel Hauagge. All rights reserved.
//

import Foundation
import Firebase

class PlayersInfoManager: NSObject {
    
    private static let myRootRef = Firebase(url:"https://crappybird.firebaseio.com/")
    
    static func savePlayerInfo(name : String, university : String, score : NSNumber) {
        let playersRef = myRootRef.childByAppendingPath("players")
        let thisPlayerRef = playersRef.childByAppendingPath(name)
        let thisPlayerInfo = ["name": name, "score": score, "university" : university]
        thisPlayerRef.setValue(thisPlayerInfo)
    }
    
    static func fetchPlayerInfoWithCapacity(capacity : UInt, reloadTableView : ((array : [NSDictionary]) -> Void)?) {
        var playersArray = [NSDictionary]()
        let playersRef = myRootRef.childByAppendingPath("players")
        playersRef.queryOrderedByChild("score").queryLimitedToLast(capacity).observeEventType(.ChildAdded, withBlock: { snapshot in
            if let playersDic = snapshot.value as? NSDictionary {
                playersArray.append(playersDic)
            }
            if playersArray.count == Int(capacity) {
                reloadTableView!(array : playersArray)
            }
        })
    }
}
