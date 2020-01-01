//
//  ViewController.swift
//  With
//
//  Created by 남수김 on 2019/12/23.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func nextVC(_ sender: Any) {
        let storyName = "LogIn"
        let vcName = "LogIn"
        let testStoryBoard = UIStoryboard(name: storyName, bundle: nil)
        let nextVC = testStoryBoard.instantiateViewController(withIdentifier: vcName)
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
}
