//
//  ViewController.swift
//  ForDream
//
//  Created by baby1234 on 13/02/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import Firebase

class MainVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.init()
    }
    
    func `init`() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.present(loginVC, animated: false, completion: nil)
            }
        }
    }
    
}

