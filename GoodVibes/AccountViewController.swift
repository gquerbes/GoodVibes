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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var user: PFUser? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    
    func configureView(){
    //configure the view
       // var query = PFQuery(className: "_user")
        //query.getObjectInBackgroundWithId((user?.objectId)!)
        
        //
        PFUser.currentUser()!.fetchInBackgroundWithBlock({ (currentUser: PFObject?, error: NSError?) -> Void in
            
            // Update your data
            
            if let user = currentUser as? PFUser {
                
                self.lblUsername.text = user.username
                
            }
        })
    
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
