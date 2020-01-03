//
//  SplashViewController.swift
//  With
//
//  Created by anhyunjun on 2020/01/03.
//  Copyright © 2020 ns. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        perform(#selector(SplashViewController.showTutorial), with: nil, afterDelay: 2.1)
    }
    @objc func showTutorial() {
        let storyboard = UIStoryboard.init(name: "LogIn", bundle: nil)
        let tutorial = storyboard.instantiateViewController(withIdentifier: "LogIn")
        present(tutorial, animated: true)
        
    }
}
