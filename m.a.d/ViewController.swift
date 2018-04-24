//
//  ViewController.swift
//  m.a.d
//
//  Created by Devansh Yerpude on 2/11/18.
//  Copyright © 2018 Devansh Yerpude. All rights reserved.
//
// Handles Login Page, is the initial view. 
import UIKit
// Imports Authentication & Database management for Firebase
import FirebaseAuth
import FirebaseDatabase


class ViewController: UIViewController {
    //basic function to load view
 
    override func viewDidLoad() {
    }
//creates objects for the email & password textfields, and the warning label.
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var message: UILabel!
    
    
    @IBOutlet weak var passText: UITextField!
    
   //action if button is pressed
    @IBAction func login(_ sender: UIButton) {
        //authenticates email & password from stored ones in database
        Auth.auth().signIn(withEmail: emailText.text!, password: passText.text!) { (user, error) in
            if user != nil
            {
                //if authenticated, moves onto "my books" screen
                self.performSegue(withIdentifier: "loginSeg", sender: self)
            }
            else{
                //otherwise displays error message
                let alert = UIAlertController(title: "Error", message: "Wrong Username or Password", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    //creates a user/pass on server, and then displays a message telling the user to log in.
    @IBAction func createAcc(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailText.text!, password: passText.text!) { (user, error) in
            let alert = UIAlertController(title: "Success!", message: "You have created an account", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
          
        }
    }
}

