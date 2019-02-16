//
//  LoginVC.swift
//  ForDream
//
//  Created by baby1234 on 14/02/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func joinBtn(_ sender: UIButton) {
        let joinVc = storyboard?.instantiateViewController(withIdentifier: "JoinVC") as! JoinVC
        self.present(joinVc, animated: true, completion: nil)
    }
    
    @IBAction func loginDoneBtn(_ sender: UIButton) {
        if email.text != nil && password != nil {
            loginEvent()
        } else {
            let alert = UIAlertController(title: "로그인실패", message: "이메일과 패스워드 모두 입력해주세요", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "네, 알겠어요", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func loginEvent() {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, err) in
            if err != nil {
                let alert = UIAlertController(title: "로그인실패", message: err.debugDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainVC
                self.present(mainVC, animated: false, completion: nil)
            } else {
                let alert = UIAlertController(title: "로그인실패", message: "ForDream에 기억되어있지 않아요ㅠㅠ", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}
