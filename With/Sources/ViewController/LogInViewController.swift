//
//  LogInViewController.swift
//  With
//
//  Created by anhyunjun on 31/12/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    @IBAction func pressLogin(_ sender: Any) {
        guard let userId = idTextField else { return  }
        guard let password = passwordTextField else { return }
        LogInService.shared.login(userId: userId, password: password){ data in
            let user_data = data as! Dataclass
            UserDefaults.standard.set(user_data.userIdx, forkey: "token")
            UserDefaults.standard.set(user_data.name, forKey:"name")
            self.present(main,animated: true)
        }
    }
}

