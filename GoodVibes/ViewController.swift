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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success, error) -> Void in
            print("Object has been saved.")
        }
    }
    
    @IBAction func btnCreateAccount(sender: AnyObject) {
        var user = PFUser()
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

