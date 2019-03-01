//
//  ViewController.swift
//  ForDream
//
//  Created by baby1234 on 13/02/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import Firebase

class MainVC: UIViewController, UITableViewDataSource {
    
    var dreamCellInfo = [[String : String]]()
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var forDreamLbl: UILabel!
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dreamCellInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dreamCell = mainTableView.dequeueReusableCell(withIdentifier: "dreamCell", for: indexPath)
        
        return dreamCell
    }
    
    @IBAction func showMenuBtn(_ sender: UIButton) {
    }
    
    @IBAction func moveToWriteBtn(_ sender: UIButton) {
        let writeVC = storyboard?.instantiateViewController(withIdentifier: "WriteVC") as! WriteVC
        self.present(writeVC, animated: true, completion: nil)
    }
    
    @IBAction func moveToSearchBtn(_ sender: UIButton) {
    }
    @IBAction func selectedDeleteBtn(_ sender: UIButton) {
    }
    @IBAction func allDeleteBtn(_ sender: UIButton) {
    }
}

