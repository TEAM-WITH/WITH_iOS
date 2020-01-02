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
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func goToModify(_ sender: Any) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "MyPageModify") as! MyPageModifyViewController
        nextVC.defaultProfileText = commentTextField.text
        nextVC.defaultBackgroundImg = backgroundImage.image
        nextVC.defaultProfileImg = profileImage.image
        
        myPageLabel.isHidden = true
        modifyBtn.isHidden = true
        nextVC.delegate = self
        nextVC.modalPresentationStyle = .overCurrentContext
        nextVC.modalTransitionStyle = .crossDissolve
        present(nextVC, animated: true)
    }
}

extension MyPageViewController: MyPageDelegate {
    func didModifyMyPage(text: String, profile: UIImage?, background: UIImage?) {
        
        myPageLabel.isHidden = false
        modifyBtn.isHidden = false
        commentTextField.text = text
        if let img = profile {
            profileImage.image = img
        }
        if let img = background {
            backgroundImage.image = img
        }
        
    }
    func cancelModify() {
        myPageLabel.isHidden = false
        modifyBtn.isHidden = false
    }
}
