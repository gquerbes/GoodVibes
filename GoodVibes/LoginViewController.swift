//
//  LoginViewController.swift
//  GoodVibes
//
//  Created by Gabriel Querbes on 3/27/16.
//  Copyright © 2016 The Modern Tech. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogin(sender: AnyObject) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        PFUser.logInWithUsernameInBackground(txtUsername.text!, password: txtPassword.text!){
            (user: PFUser?, error:NSError?) -> Void in
            if user != nil{
               print("success!")
                alert.title = "Success!"
                alert.message = "You are now signed in"
                
            }
            else{
                print("Access Denied")
                alert.title = "Error"
                //get error retured by database and set message
                if let error = error {
                    let errorString = error.userInfo["error"] as? String
                    alert.message = errorString
                }
            }
        }
        self.presentViewController(alert, animated: true, completion: nil)
        
            
        
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