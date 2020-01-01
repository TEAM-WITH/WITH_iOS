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
    @IBOutlet weak var logInBtn: UIButton!
    var idString = ""
    var pwString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.idTextField.delegate = self
        self.passwordTextField.delegate = self
        
        self.view.transform = CGAffineTransform(translationX: 0, y: 30)
        self.view.transform.isIdentity
    }
//    if textfield 에 뭐가 적혀있으면 둘다에 그럼 보라색이 켜지고 pressbutton able
   
    @IBAction func pressLogin(_ sender: Any) {
        guard let userId = idTextField.text else { return  }
        guard let password = passwordTextField.text else { return }
        UserService.shared.postLoginRequest(userId: userId, pw: password) { completionData in
            guard let state = completionData?.success else { return }
            guard let msg = completionData?.message else { return }
            
            if state {
           let storyName = "Home"
           let vcName = "Home"
           let testStoryBoard = UIStoryboard(name: storyName, bundle: nil)
           let nextVC = testStoryBoard.instantiateViewController(withIdentifier: vcName)
           nextVC.modalPresentationStyle = .fullScreen
           self.present(nextVC, animated: true)
             print("login Success")
                
                //상겅찰;
            } else {
                self.simpleAlert(title: "로그인 실패", msg: msg)
              
            }
        }
    }
    @IBAction func pressSignUp(_ sender: Any) {
    }
}
extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
            logInBtn.becomeFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.idTextField {
            if string == "" {
                idString.removeLast()
            }else {
                idString.append(string)
            }
        }else if textField == self.passwordTextField {
            if string == "" {
                pwString.removeLast()
            }else {
                pwString.append(string)
            }
        }
        textCompare()
        return true
    }
}

// idtextfield , pw textfield 에 뭐가 둘다 있음 purple isenable
//if ""
// else grey disable

extension LogInViewController {
    func textCompare() {
        if !idString.isEmpty && !pwString.isEmpty {
            self.logInBtn.setTitleColor(UIColor.white, for: .normal)
            self.logInBtn.backgroundColor = UIColor.mainPurple
            self.logInBtn.isEnabled = true
          
        } else {
            self.logInBtn.setTitleColor(UIColor.lightGray, for: .normal)
            self.logInBtn.backgroundColor = UIColor.veryLightGray
            self.logInBtn.isEnabled = false
          
            
        }
    }
}
