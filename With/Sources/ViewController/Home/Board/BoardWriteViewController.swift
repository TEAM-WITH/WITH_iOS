//
//  BoardWriteViewController.swift
//  With
//
//  Created by anhyunjun on 2020/01/03.
//  Copyright © 2020 ns. All rights reserved.
//

import UIKit


class BoardWriteViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var regionTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var writeTextView: UITextView!
    
    @IBOutlet weak var switchButton: UISwitch!
    override func viewDidLoad() {
        self.switchButton.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        super.viewDidLoad()
        titleTextField.delegate = self
        dateTextField.delegate = self
        writeTextView.delegate = self
        regionTextField.delegate = self
        self.tabBarController?.tabBar.isHidden = true
        
        
     
    }
    
    @IBAction func goToBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }}
extension BoardWriteViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            titleTextField.resignFirstResponder()
            regionTextField.becomeFirstResponder()
        } else if textField == regionTextField {
            regionTextField.resignFirstResponder()
            dateTextField.becomeFirstResponder()
        } else if textField == dateTextField {
            dateTextField.resignFirstResponder()
           writeTextView.becomeFirstResponder()
        }
        return true
    }
}

extension BoardWriteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        func textViewDidEndEditing(textView: UITextView) {
       
            if (writeTextView.text == "동행 구하는 글을 작성해주세요"){
                           writeTextView.text = ""
                           writeTextView.textColor = UIColor.black
                       }
                       writeTextView.becomeFirstResponder()
        }
        func textViewDidBeginEditing(textView: UITextView){
           if (writeTextView.text == ""){
                      writeTextView.text = "동행 구하는 글을 작성해주세요"
                      writeTextView.textColor = UIColor.lightGray
                  }
                  writeTextView.resignFirstResponder()
        }
    }
}
