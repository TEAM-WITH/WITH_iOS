//
//  MyPageModifyViewController.swift
//  With
//
//  Created by anhyunjun on 2020/01/01.
//  Copyright © 2020 ns. All rights reserved.
//

import UIKit

protocol MyPageDelegate {
    func didModifyMyPage(text: String)
}

class MyPageModifyViewController: UIViewController {
    var delegate: MyPageDelegate?

    @IBOutlet weak var myPageLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        myPageLabel.isHidden = true
    }
    @IBAction func pressXButton(_ sender: Any) {
        self.dismiss(animated: true)
        myPageLabel.isHidden = false
    }
    @IBAction func saveButton(_ sender: Any) {
        let text = commentTextField.text ?? ""
        delegate?.didModifyMyPage(text: text)
        myPageLabel.isHidden = true

        self.dismiss(animated: true)
    }
}
