//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Gary Ghayrat on 2/28/16.
//  Copyright © 2016 Gary Ghayrat. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    var isFavorited = false
    var isRetweeted = false

    let retweetTapRec = UITapGestureRecognizer()
    let likeTapRec = UITapGestureRecognizer()
    let profileImageRec = UITapGestureRecognizer()
    
    var tweet: Tweet! {
        didSet {
            
            if (tweet.user?.profileUrl != nil) {
                profileImage.setImageWithURL((tweet.user?.profileUrl)!)
            } else {
                profileImage.image = UIImage(named: "blue_logo.png")
            }
            nameLabel.text = tweet.user?.name as? String
            nameLabel.text = "@\(tweet.user!.screenname!)"
            tweetLabel.text = tweet.text as? String
            timeStamp.text = tweet.timeSince
            retweetCountLabel.text = String(tweet.retweetCount)
               if retweetCountLabel.text == "0" {
                retweetCountLabel.hidden = true
            }
            
            retweetTapRec.addTarget(self, action: "onRetweet")
            likeTapRec.addTarget(self, action: "onLike")
}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.width
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.layer.cornerRadius = 5
        profileImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func retweetButton(sender: AnyObject) {
        print("retweet clicked")
//        self.retweetButton.setImage(UIImage(named: "retweet-action-on-pressed"), forState: UIControlState.Normal)
        
        self.retweetCountLabel.text = String(self.tweet.retweetCount + 1)
    }
    @IBAction func favoriteButton(sender: AnyObject) {
        print("favorite clicked")
        
//        self.favoriteButton.setImage(UIImage(named: "like-action-on-pressed"), forState: UIControlState.Normal)
        self.favoriteCountLabel.text = String(self.tweet.favoritesCount + 1)
    }


}
