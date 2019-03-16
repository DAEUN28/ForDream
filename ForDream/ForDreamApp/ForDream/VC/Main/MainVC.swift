//
//  ViewController.swift
//  ForDream
//
//  Created by baby1234 on 13/02/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import Firebase

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dreamContainers = DreamContainer.sharedInstance
    var dream = Dream()
    var model = Model()
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var forDreamLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.init()
        
        DispatchQueue.main.async {
            self.model.fetchContainers { () in
                self.mainTableView.reloadData()
                
                if self.dreamContainers.dreamContainers.isEmpty {
                    self.forDreamLbl.isHidden = false
                } else {
                    self.forDreamLbl.isHidden = true
                }
            }
        }

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
        return dreamContainers.dreamContainers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dreamCell = mainTableView.dequeueReusableCell(withIdentifier: "Dream Cell", for: indexPath) as! DreamCell
        
        let dicTemp = dreamContainers.dreamContainers[indexPath.row]
        
        dreamCell.writedDateLbl.text! = dicTemp.writedDate
        
        return dreamCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let removeDream = dreamContainers.dreamContainers[indexPath.row]
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let alert = UIAlertController(title: nil, message: "\(removeDream.writedDate)의 꿈을 \n지우시겠어요?", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default) { (UIAlertAction) in
                DispatchQueue.main.async {
                    self.model.removeAction(removeDream: removeDream)
                    self.mainTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                }
            }
            let cancelAction = UIAlertAction(title: "아니오", style: UIAlertAction.Style.cancel, handler: nil)
            
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailPage"{
            (segue.destination as! DetailPVC).currentIndex = mainTableView.indexPathForSelectedRow!.row
        }
    }
    
    @IBAction func showMenuBtn(_ sender: UIButton) {
    }
    
    @IBAction func moveToWriteBtn(_ sender: UIButton) {
        let writeVC = storyboard?.instantiateViewController(withIdentifier: "WriteVC") as! WriteVC
        self.present(writeVC, animated: true, completion: nil)
    }
    
    @IBAction func moveToSearchBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func allDeleteBtn(_ sender: UIButton) {
        if !dreamContainers.dreamContainers.isEmpty {
            let alert = UIAlertController(title: "모두삭제", message: "저장한 모든 꿈을 지우시겠어요?", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default) { (UIAlertAction) in
                DispatchQueue.main.async {
                    self.model.removeAllAction()
                }
            }
            let cancelAction = UIAlertAction(title: "아니오", style: UIAlertAction.Style.cancel, handler: nil)
            
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: nil, message: "꿈이 없어요!", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "네", style: UIAlertAction.Style.default, handler: nil)
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }

}

