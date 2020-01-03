//
//  UIViewController+Extension.swift
//  With
//
//  Created by 남수김 on 2019/12/30.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    func simpleAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func confirmAlert(title: String, msg: String?, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "예", style: .cancel, handler: handler)
        let noAction = UIAlertAction(title: "아니오", style: .default)
        
        alert.addAction(noAction)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func simpleDismissAlert(title: String, msg: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "예", style: .cancel, handler: handler)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
