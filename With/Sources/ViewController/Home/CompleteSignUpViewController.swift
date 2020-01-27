//
//  CompleteSignUpViewController.swift
//  With
//
//  Created by anhyunjun on 2020/01/03.
//  Copyright © 2020 ns. All rights reserved.
//

import UIKit

class CompleteSignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LogIn")
        self.didMove(toParent: loginVC)
        self.view.removeFromSuperview()
        self.removeFromParent()
        self.dismiss(animated: true)
    }

}
