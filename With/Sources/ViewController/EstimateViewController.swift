//
//  EstimateViewController.swift
//  With
//
//  Created by anhyunjun on 27/12/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class EstimateViewController: UIViewController {
    
    @IBOutlet weak var travelLabel1: UILabel!
    @IBOutlet weak var trabelLabel2: UILabel!
    @IBOutlet weak var trabelLabel3: UILabel!
    @IBOutlet weak var withBtn: UIButton!
    @IBOutlet weak var funBtn: UIButton!
    @IBOutlet weak var sosoBtn: UIButton!
    @IBOutlet weak var withBtn2: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
              withBtn.layer.cornerRadius = 10
            sender.backgroundColor = UIColor.init(red: 253/255, green: 159/255, blue: 8/255, alpha: 1)
        }else {
            withBtn.layer.cornerRadius = 10
            sender.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
        }
    }
    @IBAction func pressfunBtn(_ sender: UIButton) { sender.isSelected = !sender.isSelected
               if sender.isSelected {
                funBtn.layer.cornerRadius = 10
                   sender.backgroundColor = UIColor.init(red: 253/255, green: 159/255, blue: 8/255, alpha: 1)
               }else {
                funBtn.layer.cornerRadius = 10
                   sender.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
               }
    }
    @IBAction func presssosoBtn(_ sender: UIButton) { sender.isSelected = !sender.isSelected
               if sender.isSelected {
                sosoBtn.layer.cornerRadius = 10
                   sender.backgroundColor = UIColor.init(red: 253/255, green: 159/255, blue: 8/255, alpha: 1)
               }else {
                sosoBtn.layer.cornerRadius = 10
                   sender.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
               }
    }
    @IBAction func withBtn2(_ sender: UIButton) { sender.isSelected = !sender.isSelected
                  if sender.isSelected {
                   withBtn2.layer.cornerRadius = 10
                      sender.backgroundColor = UIColor.init(red: 253/255, green: 159/255, blue: 8/255, alpha: 1)
                  }else {
                   withBtn2.layer.cornerRadius = 10
                      sender.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
                  }
       }
}
