//
//  info.swift
//  m.a.d
//
//  Created by Devansh Yerpude on 2/12/18.
//  Copyright © 2018 Devansh Yerpude. All rights reserved.
//
import Social
import UIKit
//import database
import FirebaseDatabase
import Social


class info: UIViewController {

 @IBOutlet weak var bugText: UITextView!
   
    @IBOutlet weak var shareText: UITextView!
    @IBAction func beingTyped(_ sender: UITapGestureRecognizer) {
        
        bugText.text = ""
    }
    
    @IBAction func typer(_ sender: UITapGestureRecognizer) {
        shareText.text = ""
    }
    
    @IBAction func onshare(_ sender: Any) {
        let activity = UIActivityViewController(activityItems: [shareText.text!, #imageLiteral(resourceName: "Social.png")], applicationActivities: nil)
        present(activity, animated: true, completion: nil)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bugText.layer.borderColor = UIColor.white.cgColor
        bugText.layer.borderWidth = 2
    
    }
    //when button is pressed, sends data inside textField to database, where developer can see bug complaint
    @IBAction func entry(_ sender: Any) {
    
    
    Database.database().reference().child("bugs").childByAutoId().setValue(["description": bugText!])

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func texty(_shareText:UITextView, _bugText:UITextView) -> Bool {
        shareText.resignFirstResponder()
        bugText.resignFirstResponder()
        return(true)
    }
    
    
    @IBAction func email(_ sender: Any) {
        UIApplication.shared.open(URL(string: "mailto:iLibrary@nhs.org")! as URL, options: [:], completionHandler: nil)
        
    }
    
    @IBAction func website(_ sender: Any) {
        if let url = URL(string: "https://nhsilibrary.weebly.com") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    
    }
    
    

    
    


