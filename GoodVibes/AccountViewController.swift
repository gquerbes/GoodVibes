//
//  AccountViewController.swift
//  GoodVibes
//
//  Created by Gabriel Querbes on 3/27/16.
//  Copyright © 2016 The Modern Tech. All rights reserved.
//

import UIKit
import Parse

class AccountViewController: UIViewController {

    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBAction func btnLogout(sender: AnyObject) {
        PFUser.logOut()
    }
   
    @IBOutlet weak var spnLoading: UIActivityIndicatorView!
    
    var user : PFUser?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configureView(){
        PFUser.currentUser()!.fetchInBackgroundWithBlock({ (currentUser: PFObject?, error: NSError?) -> Void in
            //if account logged in successfully, process
            if let user = currentUser as? PFUser {
                self.user = user
                
                if let address = user.objectForKey("address"){
                    let streetAddress = address.objectForKey("street_address") as! String
                    let city = address.objectForKey("city") as! String
                    let state = address.objectForKey("state") as! String
                    let zip = address.objectForKey("zip") as! String
                    
                    self.lblUsername.text = user.username
                    self.lblEmail.text = user.email
                    self.lblAddress.text = "\(streetAddress), \(city) \(state), \(zip)"
                    self.lblMobileNumber.text = user.objectForKey("mobile_number") as? String
                }
                
                
    
            }
        })
    }

    
    override func viewWillAppear(animated: Bool) {
        spnLoading.startAnimating()
        configureView()
        spnLoading.stopAnimating()
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
