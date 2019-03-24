//
//  MenuVC.swift
//  ForDream
//
//  Created by baby1234 on 17/02/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MenuTVC: UITableViewController {
    
    @IBOutlet var menuNavigationItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let i = Auth.auth().currentUser!.email!.firstIndex(of: "@") {
            let userName = Auth.auth().currentUser!.email!.prefix(upTo: i)
            menuNavigationItem.title = "\(userName)님의 꿈"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier: "StarStorageVC") as! StarStorageVC
            present(vc, animated: false, completion: nil)
        case 1:
            self.logout()
        case 2:
            self.withdrawal()
        default:
            print("Error")
        }
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            present(vc, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func withdrawal() {
        let user = Auth.auth().currentUser
        let base = Base()
        
        base.ref.child("users").child(base.uid!).removeValue()
        
        user?.delete { error in
            if let error = error {
                print(error)
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.present(vc, animated: false, completion: nil)
            }
        }
    }
}
