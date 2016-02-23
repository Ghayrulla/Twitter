//
//  logInViewController.swift
//  Twitter
//
//  Created by Gary Ghayrat on 2/22/16.
//  Copyright © 2016 Gary Ghayrat. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class logInViewController: UIViewController {

    @IBAction func onLoginButton(sender: AnyObject) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com")! , consumerKey: "VOLSDieW9oKDKxIQ4MbrMGkiJ", consumerSecret: "0YrJdTZm2TpkRSiurzpUhr2U9vNM43f6rVm0ISPfZu4XfQfHNj")
    
    
        twitterClient.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterapp://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
    print("I got a token!")
    
    let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
        UIApplication.sharedApplication().openURL(url)
    
    }) { (error: NSError!) -> Void in
        print("error: \(error.localizedDescription)")
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
