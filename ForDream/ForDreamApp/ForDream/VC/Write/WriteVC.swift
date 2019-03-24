//
//  WriteVC.swift
//  ForDream
//
//  Created by baby1234 on 15/02/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import SwiftyPickerPopover

class WriteVC: UIViewController, UITextFieldDelegate {
    
    var dreamContainer = DreamContainer.sharedInstance
    var dream = Dream()
    var model = Model()
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func moveToMainBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickWritingDateBtn(_ sender: UIButton) {
        var dateContainer: String?
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        DatePickerPopover(title: "꿈꾼 날짜")
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
        if detailTxtView.text != "" {
            let alert = UIAlertController(title: "저장", message: "저장하시겠어요?", preferredStyle: UIAlertController.Style.alert)
            let doneAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (_) in
                self.DateCheckAndSave()
                self.dismiss(animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
           
            alert.addAction(cancelAction)
            alert.addAction(doneAction)
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요ㅠ", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "넹", style: UIAlertAction.Style.default, handler: nil)
    
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func DateCheckAndSave() {
        dream.writedDate = writingDateBtn.currentTitle!
        dream.detailTxt = detailTxtView.text
        
        if dreamContainer.dreamContainers.contains(where: { (Dream) -> Bool in
            if Dream.writedDate == dream.writedDate {
                return true
            } else {
                return false
            }
        }) {
            let alert = UIAlertController(title: "이미 등록된 날짜에요", message: "이전의 내용을 삭제하고 새로운 내용으로 저장할까요?", preferredStyle: UIAlertController.Style.alert)
            
            let doneAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default) { _ in
                self.model.saveAction(dream: self.dream, index: self.dreamContainer.dreamContainers.count)
                self.dismiss(animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "아니오", style: UIAlertAction.Style.cancel, handler: nil)
            
            alert.addAction(cancelAction)
            alert.addAction(doneAction)
            
            present(alert, animated: true, completion: nil)
        } else {
            model.saveAction(dream: dream, index: dreamContainer.dreamContainers.count)
            dismiss(animated: true, completion: nil)
        }
    }
    
}
