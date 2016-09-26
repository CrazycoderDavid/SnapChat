//
//  SnapsVC.swift
//  Snapchat
//
//  Created by David Groomes on 9/22/16.
//  Copyright © 2016 Arc Towers. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class SnapsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var snaps : [Snap] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            
            print("David: \(snapshot)")
            
            let snap = Snap()
            snap.imageURL = (snapshot.value as! NSDictionary)["imageURL"] as! String
            snap.from = (snapshot.value as! NSDictionary)["from"] as! String
            snap.descrip = (snapshot.value as! NSDictionary)["description"] as! String
            snap.key = snapshot.key
            snap.uuid = (snapshot.value as! NSDictionary)["uuid"] as! String
            
            self.snaps.append(snap)
            self.tableView.reloadData()
            
        })

        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childRemoved, with: {(snapshot) in
            
            
            let snap = Snap()
            snap.imageURL = (snapshot.value as! NSDictionary)["imageURL"] as! String
            snap.from = (snapshot.value as! NSDictionary)["from"] as! String
            snap.descrip = (snapshot.value as! NSDictionary)["description"] as! String
            snap.key = snapshot.key
            snap.uuid = (snapshot.value as! NSDictionary)["uuid"] as! String
            
            var index = 0
            for snap in self.snaps {
                if snap.key == snapshot.key{
                    self.snaps.remove(at: index)
                }
                index += 1
            }
            
            self.tableView.reloadData()
            
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if snaps.count == 0 {
            return 1
        }else {
        return snaps.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if snaps.count == 0 {
            cell.textLabel?.text = " You don't have any Snaps 😱"
            cell.isUserInteractionEnabled = false
        }else {
            cell.isUserInteractionEnabled = true
        let snap = snaps[indexPath.row]
        cell.textLabel?.text = snap.from
        }
        
        return cell
        }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "viewSnap", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewSnap" {
        
        let nextVC = segue.destination as! ViewSnapVC
        nextVC.snap = sender as! Snap
        }        
    }
    
    @IBAction func logOutTapped(_ sender: AnyObject) {
    dismiss(animated: true, completion: nil)
    }
    

}
