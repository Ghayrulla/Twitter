//
//  Tweet.swift
//  Twitter
//
//  Created by Gary Ghayrat on 2/28/16.
//  Copyright © 2016 Gary Ghayrat. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var user: User?
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var timePassed: Int?
    var timeSince: String!
    var id: Int?
    var userID: String?
    var profileImageUrl: NSURL?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        text = dictionary["text"] as? String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as?  Int) ?? 0
        
        id = (dictionary["id"] as! Int)
        let userDictionary = dictionary["user"] as! NSDictionary
        profileImageUrl = NSURL( string: userDictionary["profile_image_url"] as! String)
        userID = userDictionary["id_str"] as? String
        let timestampString = dictionary["created_at"] as? String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        
        if let timestampString = timestampString {
        timestamp = formatter.dateFromString(timestampString)
            
            let now = NSDate()
            let then = timestamp
            timePassed = Int(now.timeIntervalSinceDate(then!))
            
            // creds for this function go to @dylan-james-smith from ccsf
            if timePassed >= 86400 {
                timeSince = String(timePassed! / 86400)+"d"
            }
            if (3600..<86400).contains(timePassed!) {
                timeSince = String(timePassed!/3600)+"h"
            }
            if (60..<3600).contains(timePassed!) {
                timeSince = String(timePassed!/60)+"m"
            }
            if timePassed < 60 {
                timeSince = String(timePassed!)+"s"
            }
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
    }
    
}
