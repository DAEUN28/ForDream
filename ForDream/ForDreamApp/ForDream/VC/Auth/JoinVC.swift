//
//  JoinVC.swift
//  ForDream
//
//  Created by baby1234 on 14/02/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import Firebase
import UIColor_Hex_Swift

class JoinVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rePassword: UITextField!
    @IBOutlet weak var lblPasswordError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.init()
        
    }
    
    @IBAction func moveToLoginPage(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func joinDoneBtn(_ sender: UIButton) {
        if let pwTxt = password.text {
            if pwTxt == rePassword.text! && email.text != nil && password.text != nil{
                joinEvent()
            } else {
                lblPasswordError.textColor = UIColor("#FF0000")
                lblPasswordError.isHidden = false
                lblPasswordError.text = "비밀번호가 맞지 않아요"
            }
        }
        
    }
    
    func `init`() {
        lblPasswordError.isHidden = true
    }
    
    func joinEvent() {
        lblPasswordError.isHidden = true
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!, completion: { (user, err) in
            if let uid = user?.user.uid {
                Database.database().reference().child("users").child(uid).child("userInfo").setValue(
                    ["email" : self.email.text!,
                    "password" : self.password.text!])
                
                let alert = UIAlertController(title: "회원가입 성공!", message: "로그인해주세요", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (alertAction) in
                self.dismiss(animated: true, completion: nil)}))
                
            } else {
                let alert = UIAlertController(title: "오류!", message: "회원가입에 실패했어요", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (alertAction) in
                self.dismiss(animated: true, completion: nil)}))
            }
                    
        })
        
    }
}

