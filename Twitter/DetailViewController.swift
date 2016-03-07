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
    
    var tweet: Tweet!
    override func viewDidLoad() {
        super.viewDidLoad()
        
  //      var tweet: Tweet! {
  //          didSet {
        
        if (tweet.profileImageUrl == nil) {
            profileImage.setImageWithURL(tweet.profileImageUrl!)
        } else {
            profileImage.image = UIImage(named: "blue_logo.png")
        }
      //  profileImage.setImageWithURL(tweet.user!.profileUrl!)
        nameLabel.text = tweet.user!.name as? String
        userNameLabel.text = tweet.user?.name as? String
        userNameLabel.text = "@\(tweet.user!.screenName!)"
        tweetLabel.text = (tweet.text as! String)
        timeStamp.text = String(tweet.timestamp!)
        nRetweets.text = String(tweet.retweetCount)
        if nRetweets.text == "0" {
            nRetweets.hidden = true
        }
        nFavorites.text = String(tweet.favoritesCount)
        if nFavorites.text == "0" {
            nRetweets.hidden = true
            
        }
        // Do any additional setup after loading the view.
        tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.size.width
        // Do any additional setup after loading the view.
    //}
    //    }
        }
    @IBAction func ReplyButton(sender: AnyObject) {
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
