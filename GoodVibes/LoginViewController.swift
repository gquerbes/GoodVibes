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
    
    //Variables
    var user: PFUser?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        //Looks for single or multiple taps
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    @IBAction func btnLogin(sender: AnyObject) {
        
        login()
    }
    
    @IBAction func btnCreateAccount(sender: AnyObject) {
    }
    
    
    func login(){
       PFUser.logInWithUsernameInBackground(txtUsername.text!, password: txtPassword.text!){
            (user: PFUser?, error:NSError?) -> Void in
            if user != nil{
                print("success!")
                self.user = user
                self.performSegueWithIdentifier("login", sender: self)
            }
                
            else{
                //get error retured by database and set message
                if let error = error {
                    let errorString = error.userInfo["error"] as? String
                    print(errorString)
                    
                }
            }
        }
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    // MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "login"{
            if user != nil{
                let controller = (segue.destinationViewController ) as! AccountViewController
            }
            else{
                print("user is nil")

                
            }
        }
        
    }


}