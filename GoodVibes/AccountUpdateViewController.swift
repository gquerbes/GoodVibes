//
//  AccountUpdateViewController.swift
//  GoodVibes
//
//  Created by Gabriel Querbes on 3/31/16.
//  Copyright © 2016 The Modern Tech. All rights reserved.
//

import UIKit
import Parse

class AccountUpdateViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtStreetAddress: UITextField!
    
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtZip: UITextField!
    
    var user: PFUser?
    
    @IBAction func btnUpdateAccount(sender: AnyObject) {
        updateAccount()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        //Looks for single or multiple taps
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func configureView(){
        
        //find current user
        PFUser.currentUser()!.fetchInBackgroundWithBlock({ (currentUser: PFObject?, error: NSError?) -> Void in
            // try to set user to currentUser
            if let user = currentUser as? PFUser {
                self.user = user
                self.txtUsername.text = user.username
                self.txtEmail.text = user.email
                self.txtPassword.text = "****Under Construction****" //add functionality
                
                //get custom attributes from user document and pass to text boxes
                self.txtMobileNumber.text = user.objectForKey("mobile_number") as? String
                let address = user.objectForKey("address")
                self.txtStreetAddress.text = address!.objectForKey("street_address") as? String
                self.txtState.text = address!.objectForKey("state") as? String
                self.txtCity.text = address!.objectForKey("city") as? String
                self.txtZip.text = address!.objectForKey("zip") as? String
                
                
            
            }
        })
    }

    //update account information
    func updateAccount(){
        self.user?["mobile_number"] = txtMobileNumber.text
        self.user?["address.street_address"] = txtStreetAddress.text
        self.user?["address.city"] = txtCity.text
        self.user?["address.state"] = txtState.text
        self.user?["address.zip"] = txtZip.text
        //save changes
        user?.saveInBackground()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //hide keyboard
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
