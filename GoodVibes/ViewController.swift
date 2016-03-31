//
//  ViewController.swift
//  GoodVibes
//
//  Created by Gabriel Querbes on 3/19/16.
//  Copyright © 2016 The Modern Tech. All rights reserved.
//

import UIKit
import Parse


class ViewController: UIViewController {

    
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    
    var user : PFUser!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    
        user = PFUser.currentUser()
               
        autologin()
       
    
    }
    
    func autologin(){
        if user.username != nil{
            print("you are signed in \(user?.username)")
            dispatch_async(dispatch_get_main_queue()) {//this line makes next line work.... FML
                self.performSegueWithIdentifier("autoLogin", sender: self)
            }
        }
        else {
            // Show the signup or login screen
            print("you are not signed in")
        }
    }
    
    
    
    
    @IBAction func btnCreateAccount(sender: AnyObject) {
        let user = PFUser()
        user.username = txtUsername.text
        user.password = txtPassword.text
        user.email = txtEmailAddress.text
        
        user.signUpInBackgroundWithBlock{
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                //show error string somewhere and let user retry
                print (errorString)
            }
            else{
                //you have logged in!
                print( "Welcome New User!")
            }
            
        }

    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "autoLogin"{
            
           
           
        }
        
    }


}

