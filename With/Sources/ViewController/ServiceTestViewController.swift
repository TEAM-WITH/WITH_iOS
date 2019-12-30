//
//  ServiceTestViewController.swift
//  With
//
//  Created by 남수김 on 2019/12/29.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class ServiceTestViewController: UIViewController {
    var user1: SignUpModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFommatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko")
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
        
//        guard var birth = dateFommatter.date(from: "1996-02-10") else { return }
//        birth.addTimeInterval(60*60*24)
        user1 = SignUpModel(userId: "nsns", password: "123", name: "남수", birth: "1996-02-10", gender: -1)
    }
    
    @IBAction func sendRequest(_ sender: Any) {
        UserService.shared.postSignUpRequest(userData: user1) { data in
            print(data)
        }
    }
    
}
