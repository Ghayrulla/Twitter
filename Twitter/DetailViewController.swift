//
//  DetailViewController.swift
//  Twitter
//
//  Created by Gary Ghayrat on 3/6/16.
//  Copyright © 2016 Gary Ghayrat. All rights reserved.
//

import UIKit
import AFNetworking

class DetailViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var nRetweets: UILabel!
    @IBOutlet weak var retweet: UILabel!
    @IBOutlet weak var nFavorites: UILabel!
    @IBOutlet weak var favorite: UILabel!
    
    let profileTap = UITapGestureRecognizer()
    
    var tweet: Tweet!
    override func viewDidLoad() {
        super.viewDidLoad()

                userNameLabel.text = tweet.user?.name as? String
                userNameLabel.text = "@\(tweet.user!.screenName!)"
                if (tweet.user?.profileUrl != nil) {
                    profileImage.setImageWithURL((tweet.user?.profileUrl)!)
                } else {
                    profileImage.image = UIImage(named: "blue_logo.png")
                }
                nameLabel.text = tweet.user!.name as? String

                tweetLabel.text = tweet.text as? String
                timeStamp.text = tweet.timeSince
                nRetweets.text = String(tweet.retweetCount)
                if nRetweets.text == "0" {
                    nRetweets.hidden = true
                }
        
                nFavorites.text = String(tweet.favoritesCount)
                if nFavorites.text == "0" {
                    nFavorites.hidden = true
                }
            

        tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.size.width

        profileTap.addTarget(self, action: "gotoProfile")
        profileImage.userInteractionEnabled = true
        profileImage.addGestureRecognizer(profileTap)
    }
    @IBAction func ReplyButton(sender: AnyObject) {
        
    }
    
    func gotoProfile() {
        performSegueWithIdentifier("gotoProfile", sender: profileImage)
    }
        
    @IBAction func RetweetButton(sender: AnyObject) {
        let id = tweet.id
        
        //now send the request
        TwitterClient.sharedInstance.retweet(id!, success: { (tweet:Tweet) -> () in
            print("successful retweet!")
            print(tweet.text)
            }) { (error:NSError) -> () in
                print("error with retweet")
                print(error.localizedDescription)
        }
        
        //update the count
        tweet.retweetCount += 1

    }
    @IBAction func FavoriteButton(sender: AnyObject) {
        let id = tweet.id
        
        //now send the request
        TwitterClient.sharedInstance.favorite(id!, success: { (tweet:Tweet) -> () in
            print("successful favorite!")
            print(tweet.text)
            }) { (error:NSError) -> () in
                print("error with favorite")
                print(error.localizedDescription)
        }
        
        //update the count
        tweet.favoritesCount += 1

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "gotoProfile") {
            let vc = segue.destinationViewController as! ProfileViewController
            vc.user = tweet!.user
        }
    }
}



