//
//  calendarViewController.swift
//  m.a.d
//
//  Created by Devansh Yerpude on 5/1/18.
//  Copyright © 2018 Devansh Yerpude. All rights reserved.
//
import Firebase
import FirebaseStorage
import UIKit
import FirebaseDatabase
import EventKit
import EventKitUI

class calendarViewController: UIViewController {
var event = "event1"
  
    override func viewDidLoad() {
        super.viewDidLoad()
        getValues()
        
        imageStuff.layer.borderColor = UIColor.white.cgColor
        imageStuff.layer.borderWidth = 2
        
        
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }
     var ref: DatabaseReference!
    @IBOutlet var imageStuff: UIImageView!
    @IBOutlet var titleText: UILabel!
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var dateText: UILabel!
    @IBOutlet var locationText: UILabel!
    @IBOutlet var descriptionText: UILabel!
    var year = 2018
    var day = 05
    var month = 10
    var someDate = Date()
    
    func date(){
    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = month
    dateComponents.day = day
    // Create date from components
    let userCalendar = Calendar.current // user calendar
    let someDateTime = userCalendar.date(from: dateComponents)
        someDate = someDateTime!
        
    }
    
    
    
  
    
    
    
    
    @IBAction func segmenter(_ sender: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            event = "awesome"
            getValues()
        case 1:
           event = "amazing"
            getValues()
        default:
           getValues()
            break;
        }
    }
        
    

func getValues(){
    var imageRef:StorageReference{
        return Storage.storage().reference()
    }
    let ref = Database.database().reference()
    if(event == "amazing"){
        day = 28
        month = 8
        year = 2018
        var downloadRef = imageRef.child("event1.jpg")
        var downloadTask = downloadRef.getData(maxSize: 1024*1024*12) { (data, error) in
            if let data = data {
                let image = UIImage(data:data)
                self.imageStuff.image = image
            }
        }
    }
    else{
        day = 16
        month = 7
        year = 2018
        var downloadRef = imageRef.child("event2.jpg")
        var downloadTask = downloadRef.getData(maxSize: 1024*1024*12) { (data, error) in
            if let data = data {
                let image = UIImage(data:data)
                self.imageStuff.image = image
            }
        }
    }
    
    
    ref.child("bugs").child(event).child("details").observeSingleEvent(of: .value) { (snapshot) in
        let m = snapshot.value as?String
        
   self.descriptionText.text = m
        
    }
    
    ref.child("bugs").child(event).child("title").observeSingleEvent(of: .value) { (snapshot) in
        let m = snapshot.value as?String
        
       self.titleText.text = m
    }
    ref.child("bugs").child(event).child("location").observeSingleEvent(of: .value) { (snapshot) in
        let m = snapshot.value as?String
        
        self.locationText.text = m
        
    }
    
    ref.child("bugs").child(event).child("date").observeSingleEvent(of: .value) { (snapshot) in
        let m = snapshot.value as?String
        
        self.dateText.text = m
    }
    
   
    
        
    
    }
    
    
    
}
    
  



