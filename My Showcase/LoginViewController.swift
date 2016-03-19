//
//  LoginViewController.swift
//  My Showcase
//
//  Created by Joseph Pilon on 3/19/16.
//  Copyright © 2016 Gulp Technologies. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
    }
    
    @IBAction func emailBtnTapped(sender: UIButton) {
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
            
            DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { error, authData in
                if error != nil {
                    if let errorCode = FAuthenticationError(rawValue: error.code) {
                        var errorMsg = ""
                        var showRegister = false
                        switch errorCode {
                        case .InvalidPassword:
                            errorMsg = "Invalid Password"
                        case .InvalidEmail:
                            errorMsg = "Invalid Email Address"
                        case .UserDoesNotExist:
                            showRegister = true
                            errorMsg = "User Does not Exist"
                        case .NetworkError:
                            errorMsg = "Network Error"
                        case .LimitsExceeded:
                            errorMsg = "Limit Exceeded, please try again"
                        default:
                            errorMsg = "\(errorCode)"
                        }
                        if showRegister {
                            self.showRegisterAlert("User Not Found", msg: "User does not exist, check the email or click ok to register!", email: email, pwd: pwd)
                        } else {
                            self.showErrorAlert("Error Logging In", msg: errorMsg)
                        }
                        
                    }
                } else {
                    //print(authData.uid)
                    //NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKeyPath: KEY_UID)
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                }
            })
            
            // Add OK to register new user or Cancel to Check Data
//            DataService.ds.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: { error, authData in
//                    if error != nil {
//                        print("Error Creating account: \(error.code)")
//                    } else {
//                        NSUserDefaults.standardUserDefaults().setValue(authData[KEY_UID], forKeyPath: KEY_UID)
//                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
//                        print("Successfully created user account with uid: \(uid)")
//                    }
//            })
            
        } else {
            showErrorAlert("Email and Password Required", msg: "You must enter an email address and password")
        }
    }
    
    func showRegisterAlert(title: String, msg: String, email: String, pwd: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default) { (alertAction) -> Void  in
            DataService.ds.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: { error, authData in
                if error != nil {
                    print("Error Creating account: \(error.code)")
                } else {
                    NSUserDefaults.standardUserDefaults().setValue(authData[KEY_UID], forKeyPath: KEY_UID)
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    //print("Successfully created user account with uid: \(KEY_UID)")
                }
            })
        }
        let cancel = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    

    @IBAction func facebookLoginTapped(sender: UIButton) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logInWithReadPermissions( [ "email" ], fromViewController: self ) { ( facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
            
            if facebookError != nil {
                
                print( "Facebook login failed. Error: \( facebookError )" )
                
            } else if facebookResult.isCancelled {
                
                print("Facebook login was cancelled.")
                
            } else {
                
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                
                print( "Successfully logged in with facebook. \( accessToken )" )
                
                DataService.ds.REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
                    
                    if error != nil {
                        print("Login failed. \(error)")
                    } else {
                        print("Logged in! \(authData)")
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKeyPath: KEY_UID)
                        self.performSegueWithIdentifier("loggedIn", sender: nil)
                    }
                    
                })
                
//                ref.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
//                        if error != nil {
//                            print("Login failed. \(error)")
//                        } else {
//                            print("Logged in! \(authData)")
//                        }
//                })
                
            }
            
        }
        

    }
}
