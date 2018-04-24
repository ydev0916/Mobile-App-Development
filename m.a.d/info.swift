//
//  info.swift
//  m.a.d
//
//  Created by Devansh Yerpude on 2/12/18.
//  Copyright © 2018 Devansh Yerpude. All rights reserved.
//

import UIKit
//import database
import FirebaseDatabase
import Social


class info: UIViewController {

    @IBOutlet weak var bugText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    
    }
    //when button is pressed, sends data inside textField to database, where developer can see bug complaint
    @IBAction func entry(_ sender: UIButton) {
    Database.database().reference().child("bugs").setValue(["description" : bugText.text!])

    }
    //even though function is deprecated, it still works since deployement target is 11.0
    //shares with Facebook
    @IBAction func faceBook(_ sender: UIButton) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
            var fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            self.present(fbShare, animated: true, completion: nil)
            
        } else {
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //shares with twitter
    @IBAction func twitter(_ sender: UIButton) {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            
            var tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            self.present(tweetShare, animated: true, completion: nil)
            
        } else {
            
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to tweet.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    

}
