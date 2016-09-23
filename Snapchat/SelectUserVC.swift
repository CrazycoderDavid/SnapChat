

import UIKit
import FirebaseDatabase

class SelectUserVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        FIRDatabase.database().reference().child("Users").observe(FIRDataEventType.childAdded, with: { (snapshot) in
            
            
            print(snapshot)
            let user = User()
            user.email = (snapshot.value as! NSDictionary)["email"] as! String
            user.uid = snapshot.key
            
            self.users.append(user)
            self.tableView.reloadData()
            
        })
       
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        FIRDatabase.database().reference().child("users")
        let user = users[indexPath.row]
        
        let snap = ["from":user.email, "description":"hello", "image":"www.go.com"]
        
        FIRDatabase.database().reference().child("Users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
    }
}
