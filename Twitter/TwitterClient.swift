//
//  TwitterClient.swift
//  Twitter
//
//  Created by Gary Ghayrat on 2/28/16.
//  Copyright © 2016 Gary Ghayrat. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class TwitterClient: BDBOAuth1SessionManager {

    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "GEln7oOgsZ2vFJwaIy6m0ipOY", consumerSecret: "7gcNOAWOFFwly8XxCyQ3Agdf5UDFJqOwktjDxGLJnyNhY6jlb1")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(success: () -> (), failure: (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitterapp://oauth"), scope: nil, success: { (requestToken  : BDBOAuth1Credential!) -> Void in
            
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
            })
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func homeTimeLine(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
//            let dictionariess = response as! NSArray
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            
            
            
            }, failure:  { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
        
    }
    
    func getUser(screenName: String, success: (User) -> (), failure: (NSError)->()){
        GET("1.1/users/show.json", parameters: ["screen_name":screenName], progress: nil, success: { (task:NSURLSessionDataTask, response:AnyObject?) -> Void in
            let userDict = response as! NSDictionary
            
            //initialize a user object
            let user = User(dictionary: userDict)
            
            //call the success function
            success(user)
            
            print("name: \(user.name)")
            print("screen name: \(user.screenName)")
//            print("description: \(user.profileDescription)")
            }, failure: { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                failure(error)
        })
    }
    
    func retweet(id:Int,success: (Tweet)->(), failure: (NSError)->()){
        POST("1.1/statuses/retweet/\(id).json", parameters: nil, constructingBodyWithBlock: nil, progress: nil, success: { (task:NSURLSessionDataTask, tweetjson:AnyObject?) -> Void in
            let tweetdict = tweetjson as! NSDictionary
            let tweet = Tweet(dictionary: tweetdict)
            
            success(tweet)
            
            }) { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                print(error.localizedDescription)
                failure(error)
        }
    }
    
    func favorite(id:Int,success: (Tweet)->(), failure: (NSError)->()){
        POST("1.1/favorites/create.json", parameters: ["id":"\(id)"], constructingBodyWithBlock: nil, progress: nil, success: { (task:NSURLSessionDataTask, tweetjson:AnyObject?) -> Void in
            let tweetdict = tweetjson as! NSDictionary
            let tweet = Tweet(dictionary: tweetdict)
            
            success(tweet)
            
            }) { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                print(error.localizedDescription)
                failure(error)
        }
    }
    
    func userTimeline(userID: String, success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        let params = ["screen_name": userID] as NSDictionary
        GET("1.1/statuses/user_timeline.json", parameters: params, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            success(tweets)
            }, failure: { (task: NSURLSessionDataTask?, error:NSError) -> Void in
                failure(error)
            }
        )
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("account: \(response)")
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            }, failure:  { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func compose(params: NSDictionary, success: ()->()) {
        POST("1.1/statuses/update.json", parameters: params, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            success()
            }) { (task:NSURLSessionDataTask?, error: NSError) -> Void in
                print("error \(error.localizedDescription)")
        }
    }
    
}
