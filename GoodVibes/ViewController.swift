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
    
    var userObjectArray = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getUsers()
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
    
    var userArray = [AnyObject]()
    //get user objects from server
    func getUsers(){
        var numUsers = 0
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            
            let query = PFUser.query()
            
            
            do{
                //query?.cachePolicy = .CacheThenNetwork
                
                query?.whereKey("email", notEqualTo: "")
                self.userArray = try query!.findObjects()
                
                query?.findObjectsInBackgroundWithBlock() {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    if error == nil {
                        // Results were successfully found, looking first on the
                        // network and then on disk.
                        
                        
                            
                            numUsers = self.userArray.count
                            print(numUsers)
                        
                    } else {
                        // The network was inaccessible and we have no cached data for
                        // this query.
                    }
                }
            }
            catch _ {
            }
            
        }
        
         //  self.setUsers(self.userArray)
        
    }
    
    
//    func setUsers(user: [AnyObject]){
//        //print (userArray[0])
//        for index in 0...user.count{
//           // var aUser = user[index]
//            if let username = user[index].username{
//                if let email = user[index].password{
//                    let userObject = User(username: username!, email: email!)
//                    userObjectArray.append(userObject)
//                    
//                }
//                print("error1")
//                
//            }
//            print("error2")
//        }
//    }
    
    
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

