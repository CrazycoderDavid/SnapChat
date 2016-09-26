//
//  ViewSnapVC.swift
//  Snapchat
//
//  Created by David Groomes on 9/23/16.
//  Copyright © 2016 Arc Towers. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class ViewSnapVC: UIViewController {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = snap.descrip
        imageview.sd_setImage(with: URL(string: snap.imageURL))
        
    }
  
    override func viewWillDisappear(_ animated: Bool) {
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").child(snap.key).removeValue()
        
        FIRStorage.storage().reference().child("images").child("\(snap.uuid).jpg").delete { (error) in
            print("Deleted Pic")
        }
        
    }
    
    
    
}
