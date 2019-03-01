//
//  WriteVC.swift
//  ForDream
//
//  Created by baby1234 on 15/02/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import Firebase
import SwiftyPickerPopover

class WriteVC: UIViewController {
    
    var ref = Database.database().reference()
    var dreamContainers = DreamContainer.sharedInstance
    var dream = Dream()
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var detailTxtView: UITextView!
    @IBOutlet weak var writingDateBtn: UIButton!
    @IBOutlet weak var starStorageBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        writingDateBtn.setTitle(dateFormatter.string(from: date), for: UIControl.State.normal)
    }
    
    @IBAction func moveToMainBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickWritingDateBtn(_ sender: UIButton) {
        var dateContainer: String?
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        _ = DatePickerPopover(title: "꿈꾼 날짜")
            .setDateMode(.date)
            .setSelectedDate(Date())
            .setDoneButton(action: { popover, selectedDate in
                dateContainer = self.dateFormatter.string(from: selectedDate as Date)
                if let tmp = dateContainer {
                    self.writingDateBtn.setTitle(tmp, for: UIControl.State.normal)
                }})
            .setCancelButton(action: { _, _ in print("cancel")})
            .appear(originView: sender, baseViewController: self)
        
    }
    
    @IBAction func starStorageActionBtn(_ sender: UIButton) {
        if dream.starStorageIsChecked {
            starStorageBtn.setImage(UIImage(named: "selectStar.png"), for: UIControl.State.normal)
            dream.starStorageIsChecked = false
        } else {
            starStorageBtn.setImage(UIImage(named: "selectedStar.png"), for: UIControl.State.normal)
            dream.starStorageIsChecked = true
        }
    }
    
    @IBAction func saveActionBtn(_ sender: UIButton) {
        if detailTxtView.text != nil {
            let alert = UIAlertController(title: "저장완료", message: "저장하시겠어요?", preferredStyle: UIAlertController.Style.alert)
            let doneAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (_) in
                self.saveAction()
                self.dismiss(animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
           
            alert.addAction(cancelAction)
            alert.addAction(doneAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func saveAction() {
        let uid = Auth.auth().currentUser?.uid
        
        dream.detailTxt = detailTxtView.text!
        dream.writedDate = writingDateBtn.currentTitle!
        
        dreamContainers.dreamContainers.append(dream)
        
        let idx = String(dreamContainers.dreamContainers.count)
        ref.child("users").child(uid!).child("dream").child(idx).child("content").setValue(dream.detailTxt)
        ref.child("users").child(uid!).child("dream").child(idx).child("writeDate").setValue(dream.writedDate)
        ref.child("users").child(uid!).child("dream").child(idx).child("starStorage").setValue(dream.starStorageIsChecked)
        
    }
    
}
