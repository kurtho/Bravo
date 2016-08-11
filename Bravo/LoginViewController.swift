//
//  LoginViewController.swift
//  Bravo
//
//  Created by KurtHo on 2016/8/10.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var fbView: UIView!
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var fbImage: UIImageView!
    @IBOutlet weak var fbName: UILabel!
    
    
    let logginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["public_profile", "email", "user_friends"]
        return button
    }()
    
    func fetchProfile() {
        print("fetch profile")
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
            if error != nil {
                print(error)
            }
            if let picture = result["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                print(url)
                let myImage =  UIImage(data: NSData(contentsOfURL: NSURL(string: url)!)!)
                self.fbImage.image = myImage
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FBSDKAccessToken.currentAccessToken() != nil {
            fetchProfile()
        }
        
        self.logginButton.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.view.layoutIfNeeded()
        self.logginButton.center = self.fbView.center
        self.view.addSubview(self.logginButton)
        
        fetchProfile()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User did log in")
        fetchProfile()
        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
            
            print("user logged in firebase")
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User did log out")
    }



}
