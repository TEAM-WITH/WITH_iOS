//
//  SignUpViewController.swift
//  With
//
//  Created by anhyunjun on 2020/01/01.
//  Copyright © 2020 ns. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var signUpSuccessView: UIView!
    
    @IBOutlet weak var defaultProfileImg: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var birthView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var confirmpwView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
//    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var girlButton: UIButton!
    @IBOutlet weak var boyButton: UIButton!
    @IBOutlet weak var girlPurpleImg: UIImageView!
    @IBOutlet weak var boyPurpleImg: UIImageView!
    @IBOutlet weak var userRealImg: UIImageView!
    
    @IBOutlet weak var signUpButton: UIButton!
    var keyboardHeight: CGFloat = 0
    var passPos: CGPoint!
    var confirmPwPos: CGPoint!
    var namePos: CGPoint!
    var birthPos: CGPoint!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBorderWidth()
        setUI()
        
         self.defaultProfileImg.layer.cornerRadius = self.defaultProfileImg.frame.size.width / 2
    }
    
    @IBAction func changeProfileImg(_ sender: Any) {
        let profilePicker = UIImagePickerController()
             profilePicker.delegate = self
        profilePicker.sourceType = .photoLibrary
             self.present(profilePicker, animated: true, completion: nil)
               }
        func imagePickerController (_ picker: UIImagePickerController,
                                    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                
                self.userRealImg.image = image
            }
            self.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel (_ picker: UIImagePickerController) {
            self.dismiss(animated: true, completion: nil)
}

    @IBAction func pressXButton(_ sender: Any) {
        self.confirmAlert(title: "회원가입을 종료하시겠습니까?", msg: "지금까지 입력한 정보들은 저장되지 않습니다.") { (action) in
            self.dismiss(animated: true)
        }
    }
    @IBAction func pressSignUpBtn(_ sender: Any) {
        nilTest()
        
    }
    
    @IBAction func pressGirlBtn(_ sender: Any) {
        girlButton.isSelected = true
        boyButton.isSelected = false
        self.girlPurpleImg.isHidden = false
        self.boyPurpleImg.isHidden = true
    }
    @IBAction func pressBoyBtn(_ sender: Any) {
        boyButton.isSelected = true
        girlButton.isSelected = false
        self.boyPurpleImg.isHidden = false
        self.girlPurpleImg.isHidden = true
    }
    func setBorderWidth() {
        
        self.nameView.layer.borderWidth = 1
        self.nameView.layer.borderColor = UIColor.mainPurple.cgColor
        self.birthView.layer.borderWidth = 1
        self.birthView.layer.borderColor = UIColor.mainPurple.cgColor
        self.passwordView.layer.borderWidth = 1
        self.passwordView.layer.borderColor = UIColor.mainPurple.cgColor
        self.confirmpwView.layer.borderWidth = 1
        self.confirmpwView.layer.borderColor = UIColor.mainPurple.cgColor
        self.emailView.layer.borderWidth = 1
        self.emailView.layer.borderColor = UIColor.mainPurple.cgColor
        self.emailView.layer.borderWidth = 1
        self.emailView.layer.borderColor = UIColor.mainPurple.cgColor
    }
    
    func setUI() {
        self.nameTextField.delegate = self
        self.birthTextField.delegate = self
        self.emailTextField.delegate = self
        self.nameTextField.delegate = self
        self.birthTextField.delegate = self
        
        passPos = CGPoint(x: 0, y: 109)
        confirmPwPos = CGPoint(x: 0, y: 218)
        namePos = CGPoint(x: 0, y: 327)
        birthPos = CGPoint(x: 0, y: 470)
        self.girlPurpleImg.isHidden = true
        self.boyPurpleImg.isHidden = true
        // self.button
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            textField.resignFirstResponder()
            scrollView.setContentOffset(passPos, animated: true)
            birthTextField.becomeFirstResponder()
        } else if textField == birthTextField {
            textField.resignFirstResponder()
            scrollView.setContentOffset(confirmPwPos, animated: true)
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            textField.resignFirstResponder()
            scrollView.setContentOffset(namePos, animated: true)
            nameTextField.becomeFirstResponder()
        } else if textField == nameTextField {
            textField.resignFirstResponder()
            scrollView.setContentOffset(birthPos, animated: true)
            birthTextField.becomeFirstResponder()
        }
        return true
    }
}


extension SignUpViewController {
    func nilTest() {
        guard let name = nameTextField.text else { return }
        guard let birth = birthTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let pw = passwordTextField.text else { return }
        guard let confirmPw = passwordConfirmTextField.text else { return }
        let userImg = userRealImg.image?.jpegData(compressionQuality: 1.0)
        
        if (name == "" || pw == "" || confirmPw == "" || email == "" || birth == ""  || (!girlButton.isSelected && !boyButton.isSelected)) {

            self.simpleAlert(title: "회원가입 실패", msg: "빈 칸을 확인해주세요")
        }else {
            var gender = 0
            if girlButton.isSelected {
                gender = -1
            } else if boyButton.isSelected {
                gender = 1
            }
            let userModel = SignUpModel(userId: email, password: pw, name: name, birth: birth, gender: gender, userImg: userImg)
            UserService.shared.postSignUpRequest(userData: userModel) { data in
            
                if data {
                    self.signUpSuccessView.isHidden = false
                   UIView.animate(withDuration: 0.4, animations: {
                            self.signUpSuccessView.alpha = 1
                    }) { _ in
                        UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                            self.signUpSuccessView.alpha = 0
                        }) { _ in
                            self.dismiss(animated: true)
                        }
                        
                    }
                } else {
                    self.simpleAlert(title: "회원가입 실패", msg: "다시 한번 시도해주세요")
                }
            }
        }
 
    }
}
