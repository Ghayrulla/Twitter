//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Gary Ghayrat on 3/7/16.
//  Copyright © 2016 Gary Ghayrat. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nTweet: UILabel!
    @IBOutlet weak var nFollowing: UILabel!
    @IBOutlet weak var nFollowers: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var user : User?
    var tweets: [Tweet]!
    var tweet: Tweet!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance.homeTimeLine({ (tweets:[Tweet]) -> () in
            self.tweets = tweets
            for tweet in tweets {
                self.tableView.reloadData()
                print(tweet.text)
                self.tableView.reloadData()
            }
            }) { (error: NSError) -> () in
                print(error.localizedDescription)
        }
        
        userNameLabel.text = tweet.user?.name as? String
        userNameLabel.text = "@\(tweet.user!.screenName!)"
        if (tweet.user?.profileUrl != nil) {
            profileImage.setImageWithURL((tweet.user?.profileUrl)!)
        } else {
            profileImage.image = UIImage(named: "blue_logo.png")
        }
        nameLabel.text = tweet.user!.name as? String
        //                nameLabel.text = tweet.user?.name as? String
        //                nameLabel.text = "@\(tweet.user!.screenName!)"
        tweetLabel.text = tweet.text as? String
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets![indexPath.row]
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
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
