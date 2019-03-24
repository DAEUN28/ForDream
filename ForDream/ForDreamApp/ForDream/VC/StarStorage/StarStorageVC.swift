//
//  TableViewController.swift
//  ForDream
//
//  Created by baby1234 on 24/03/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class StarStorageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var starStorageTableView: UITableView!
    
    var dreamContainers = DreamContainer.sharedInstance
    var starStorageDreams: [Dream]!

    override func viewDidLoad() {
        super.viewDidLoad()
        filterDream()
        self.navigationItem.title = "특별함"
    }
    
    func filterDream() {
        starStorageDreams = dreamContainers.dreamContainers.filter { (Dream) -> Bool in
            if Dream.starStorageIsChecked == true {
                return true
            } else {
                return false
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = starStorageTableView.indexPathForSelectedRow!.row
        
        if segue.identifier == "showStarStorageDetail"{
            (segue.destination as! StarStorageDetailPVC).currentIndex = row
            (segue.destination as! StarStorageDetailPVC).starStorageDreams = starStorageDreams
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starStorageDreams.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dreamCell = starStorageTableView.dequeueReusableCell(withIdentifier: "StarStorageDreamCell") as! DreamCell
        
        dreamCell.writedDateLbl.text! = starStorageDreams[indexPath.row].writedDate
        
        return dreamCell
    }
    
    @IBAction func moveToMainBtnAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
