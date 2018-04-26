//
//  authorTableViewController.swift
//  m.a.d
//
//  Created by Devansh Yerpude on 4/25/18.
//  Copyright © 2018 Devansh Yerpude. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class authorTableViewController: UITableViewController, UISearchResultsUpdating {
    var books = [NSDictionary?]()
    var filtered = [NSDictionary?]()
    var ref = Database.database().reference()
    let searcher = UISearchController(searchResultsController:nil)
    
    
    @IBOutlet var authorSe: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.child("books").queryOrdered(byChild: "author").observe(.childAdded) { (snapshot) in
            self.books.append(snapshot.value as? NSDictionary)
        }
        print(books)
        self.authorSe.insertRows(at: [IndexPath(row:self.books.count-1,section:0)], with: UITableViewRowAnimation.automatic)
        searcher.searchResultsUpdater = self
        searcher.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searcher.searchBar
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searcher.isActive && searcher.searchBar.text != ""{
            return filtered.count
        }
        else{
            return books.count
            
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    var refi: StorageReference{
        return Storage.storage().reference()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //sets the values for the cell, including author, title, and the title cover for image.
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let book : NSDictionary
        
        if searcher.isActive && searcher.searchBar.text != ""{
            book = filtered[indexPath.row]!
        }
        else {
            book = self.books[indexPath.row]!
        }
        cell.textLabel?.text = book["author"] as? String
        cell.detailTextLabel?.text = book["title"] as?
        String
        var download = refi.child((book["image"] as? String)!)
        var task = download.getData(maxSize: 1024*1024*12) { (data,error) in
            if let data = data {
                let image = UIImage(data:data)
                cell.imageView?.image = image
            }
            
            
        }
        
        
        return cell
    }
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func exit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //updates results as we search
    func updateSearchResults(for searcher: UISearchController){
        filterContent(searchText: self.searcher.searchBar.text!)
    }
    //filters content as we search
    func filterContent(searchText:String){
        self.filtered = self.books.filter{ user in
            
            let bookName = user!["author"] as? String
            return (bookName?.lowercased().contains(searchText.lowercased()))!
        }
        tableView.reloadData()
    }
    // transfers title for every cell inside tableView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let indexPath = tableView.indexPathForSelectedRow{
            let destination = segue.destination as? bookView
            let book = books[indexPath.row]
    
            
            destination?.bookTitle2 = (book!["title"] as? String)!
            
        }
    }

}
