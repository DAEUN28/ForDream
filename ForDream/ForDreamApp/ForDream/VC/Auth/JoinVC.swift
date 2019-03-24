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
import TextFieldEffects

class JoinVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: HoshiTextField!
    @IBOutlet weak var password: HoshiTextField!
    @IBOutlet weak var rePassword: HoshiTextField!
    @IBOutlet weak var lblPasswordError: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.init()
        
        email.placeholder = "이메일"
        password.placeholder = "비밀번호"
        rePassword.placeholder = "비밀번호 재입력"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func moveToLoginPage(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func joinDoneBtn(_ sender: UIButton) {
        if let pwTxt = password.text {
            if pwTxt == rePassword.text! && email.text != nil{
                joinEvent()
            } else {
                lblPasswordError.textColor = UIColor("#FF0000")
                lblPasswordError.isHidden = false
                lblPasswordError.text = "비밀번호가 맞지 않아요"
            }
        } else {
            lblPasswordError.text = "비밀번호를 입력해주세요"
        }
        
    }
    
    func `init`() {
        lblPasswordError.isHidden = true
    }
    
    func joinEvent() {
        let base = Base()
        lblPasswordError.isHidden = true
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!, completion: { (authResult, err) in
            
            if let uid = authResult?.user.uid {
                base.ref.child("users").child(uid).child("userInfo").setValue(
                    ["email" : self.email.text!,
                    "password" : self.password.text!])
                
                let alert = UIAlertController(title: "회원가입 성공!", message: "환영합니당", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { _ in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainVC
                    self.present(vc, animated: false, completion: nil)
                })
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                let alert = UIAlertController(title: "오류!", message: "회원가입에 실패했어요", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (alertAction) in
                self.dismiss(animated: true, completion: nil)}))
            }
                    
        })
        
    }
}

