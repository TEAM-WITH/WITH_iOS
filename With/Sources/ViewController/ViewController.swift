//
//  ViewController.swift
//  With
//
//  Created by 남수김 on 2019/12/23.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    @IBAction func nextVC(_ sender: Any) {
        let storyName = "Chat"
        let vcName = "ServiceTest"
        let testStoryBoard = UIStoryboard(name: storyName, bundle: nil)
        let nextVC = testStoryBoard.instantiateViewController(withIdentifier: vcName)
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }

}

extension ViewController {
    
    func setFirebase() {
//        ref = Database.database().reference()
    }
}
