//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Gary Ghayrat on 3/6/16.
//  Copyright © 2016 Gary Ghayrat. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var characterLabel: UIButton!
    @IBOutlet weak var composeText: UITextField!
    var user : User?
    var inReplyTo : String?
    var replyUserName : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.setImageWithURL(user!.profileUrl!)
        nameLabel.text = user!.name as String?
        userNameLabel.text = user!.screenName as String?
        if let replyUserName = replyUserName {
            composeText.text = "@\(replyUserName) "
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func TweetButton(sender: AnyObject) {
        var params : NSDictionary
        if let inReplyTo = inReplyTo {
            params = ["status":composeText.text!, "in_reply_to_status_id": String(inReplyTo)]
            params.setValue(String(inReplyTo), forKey: "in_reply_to_status_id")
        } else {
            params = ["status":composeText.text!]
        }
        TwitterClient.sharedInstance.compose(params) { () -> () in
            self.navigationController?.popViewControllerAnimated(true)
           // tableView.reloadData()
        }
    }
    @IBAction func CancelButton(sender: AnyObject) {
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
