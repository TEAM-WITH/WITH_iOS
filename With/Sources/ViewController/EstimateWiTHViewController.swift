//
//  EstimateWiTHViewController.swift
//  With
//
//  Created by anhyunjun on 2020/01/02.
//  Copyright © 2020 ns. All rights reserved.
//

import UIKit

class EstimateWiTHViewController: UIViewController {
    @IBOutlet weak var withBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func pressBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            withBtn.layer.cornerRadius = 10
            sender.backgroundColor = UIColor.mainPurple
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Chat") else {return}
                            nextVC.modalPresentationStyle = .overFullScreen
            self.present(nextVC, animated: true)
            
        }else {
            withBtn.layer.cornerRadius = 10
            sender.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
        }
    }
}
