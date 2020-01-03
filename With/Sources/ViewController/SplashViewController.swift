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
     //   perform(#selector(SplashVC.showTutorial), with: nil, afterDelay: 2.1)
    }
    @objc func showTutorial() {
        let token = UserDefaults.standard
        if token.string(forKey: "token") != nil {
            // 토큰이 있는 경우 바로 메인으로 이동
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let tutorial = storyboard.instantiateViewController(withIdentifier: "MainVC")
            present(tutorial, animated: true)
        }
        else {
            // 토큰이 없는 경우 튜토리얼로 이동
            let storyboard = UIStoryboard.init(name: "Tutorial", bundle: nil)
            let tutorial = storyboard.instantiateViewController(withIdentifier: "tutorial")
            present(tutorial, animated: true)
        }
    }
}
