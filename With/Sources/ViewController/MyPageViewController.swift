//
//  MyPageViewController.swift
//  With
//
//  Created by 남수김 on 2019/12/29.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {
    var comment = ""
    @IBOutlet weak var myPageLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var modifyBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    

    @IBAction func goToModify(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyPageModify") as! MyPageModifyViewController
        self
        myPageLabel.isHidden = true
        modifyBtn.isHidden = true
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
}

extension MyPageViewController: MyPageDelegate {
    func didModifyMyPage(text: String) {
        myPageLabel.isHidden = false
        modifyBtn.isHidden = false
        commentTextField.text = text
    }
}
