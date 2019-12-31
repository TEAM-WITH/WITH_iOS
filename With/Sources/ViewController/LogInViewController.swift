//
//  LogInViewController.swift
//  With
//
//  Created by anhyunjun on 31/12/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    @IBAction func pressLogin(_ sender: Any) {
        guard let userId = idTextField.text else { return  }
        guard let password = passwordTextField.text else { return }
        UserService.shared.postLoginRequest(userId: userId, pw: password) { completionData in
            guard let state = completionData?.success else { return }
            guard let msg = completionData?.message else { return }
            
            if state {
             print(completionData?.success)
               print(completionData?.message)
             print("login Success")
                //상겅찰;
            } else {
                self.simpleAlert(title: "로그인 실패", msg: msg)
                print("실패")
            }
        }
    }
    @IBAction func pressSignUp(_ sender: Any) {
    }
}
