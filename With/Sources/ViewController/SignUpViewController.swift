//
//  SignUpViewController.swift
//  With
//
//  Created by anhyunjun on 2020/01/01.
//  Copyright © 2020 ns. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topLayout: NSLayoutConstraint!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPWTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    var keyboardHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.idTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmPWTextField.delegate = self
        self.nameTextField.delegate = self
        self.birthTextField.delegate = self
        initGestureRecognizer()
        registerForKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
           unregisterForKeyboardNotifications()
       }
    
}
extension SignUpViewController {
    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        view.addGestureRecognizer(textFieldTap)
    }
    
    // 다른 위치 탭했을 때 키보드 없어지는 코드
    @objc func handleTapTextField(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // observer생성
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //observer해제
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // keyboard가 보여질 때 어떤 동작을 수행
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        //키보드의 동작시간 얻기
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        //키보드의 애니메이션종류 얻기
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        
        //키보드의 크기 얻기
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }        
        //iOS11이상부터는 노치가 존재하기때문에 safeArea값을 고려
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        self.topLayout.constant = -self.keyboardHeight/2
//        self.scrollView.contentInset = UIEdgeInsets(top: keyboardHeight + 55, left: 0, bottom: keyboardHeight + 55, right: 0)
        self.view.setNeedsLayout()
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            //animation처럼 보이게하기
            self.view.layoutIfNeeded()
        })
    }
    // keyboard가 사라질 때 어떤 동작을 수행
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        // 원래대로 돌아가도록
        self.topLayout.constant = 55
//        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.view.setNeedsLayout()
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.view.layoutIfNeeded()
        })
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTextField{
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField{
            textField.resignFirstResponder()
            confirmPWTextField.becomeFirstResponder()
        } else if textField == confirmPWTextField{
            textField.resignFirstResponder()
            nameTextField.becomeFirstResponder()
        } else if textField == nameTextField {
            textField.resignFirstResponder()
            birthTextField.becomeFirstResponder()
        }
        return true
    }
}
