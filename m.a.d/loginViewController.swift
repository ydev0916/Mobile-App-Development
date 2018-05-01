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


class loginViewController: UIViewController {
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
        if(emailText != nil && passText != nil){
        Auth.auth().signIn(withEmail: emailText.text!, password: passText.text!) { (user, error) in
            if user != nil
            {
                //if authenticated, moves onto "my books" screen
                if(self.emailText != nil && self.passText != nil){self.performSegue(withIdentifier: "loginSeg", sender: self)
                }}
            else{
                //otherwise displays error message
                let alert = UIAlertController(title: "Error", message: "Wrong Username or Password", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    }
    //creates a user/pass on server, and then displays a message telling the user to log in.
    @IBAction func createAcc(_ sender: UIButton) {
        if(emailText != nil && passText != nil){
        Auth.auth().createUser(withEmail: emailText.text!, password: passText.text!) { (user, error) in
            let alert = UIAlertController(title: "Success!", message: "You have created an account", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
          
        }
        
        
    }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    
    }
    
    func texty(_emailText: UITextField, passText: UITextField) -> Bool
    {
        emailText.resignFirstResponder()
        passText.resignFirstResponder()
        return true
    }
}

