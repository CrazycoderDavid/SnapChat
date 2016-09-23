//
//  ViewController.swift
//  Snapchat
//
//  Created by David Groomes on 9/21/16.
//  Copyright © 2016 Arc Towers. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func LetsgoButtonTapped(_ sender: AnyObject) {
    FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
        print("Attempted to sign in")
            if error != nil {
                print("There's an error: \(error)")
                
        FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
            print("Attempted to create user")
            
            if error != nil {
                print("There's an error: \(error)")
            }else{
                print("Created User")

            FIRDatabase.database().reference().child("Users").child(user!.uid).child("email").setValue(user!.email!)
             
                
                
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }

        })
        }else {
            print("Signed in successfully")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
        }
    })
    
    }
   

}

