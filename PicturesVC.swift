//
//  PicturesVC.swift
//  Snapchat
//
//  Created by David Groomes on 9/22/16.
//  Copyright © 2016 Arc Towers. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class PicturesVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func cameraTapped(_ sender: AnyObject) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func NextTapped(_ sender: AnyObject) {
        
        nextButton.isEnabled = false
        let imagesFolder =  FIRStorage.storage().reference().child("images")
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        
        
        imagesFolder.child("\(NSUUID().uuidString).jpg").put(imageData, metadata: nil) { (metadata, error) in
            print("UploadAttemped")
            if error != nil {
                print("We have and issuse \(error)")
            }else {
                
                
                print(metadata?.downloadURL())
                self.performSegue(withIdentifier: "selectUser", sender: nil)
            }
            
            
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

