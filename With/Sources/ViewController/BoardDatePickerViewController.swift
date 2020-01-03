//
//  BoardDatePickerViewController.swift
//  With
//
//  Created by 남수김 on 2020/01/02.
//  Copyright © 2020 ns. All rights reserved.
//

import UIKit

class BoardDatePickerViewController: UIViewController {

    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    var delegate: BoardPickDelegate!
    let dateFommatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let today = Date()
        self.startDatePicker.minimumDate = today
        self.endDatePicker.minimumDate = today
    }
    @IBAction func allDatePickButtonClick(_ sender: Any) {
        delegate.getAllDate?()
        self.dismiss(animated: true)
    }
    @IBAction func saveButton(_ sender: Any) {
        let sDate = dateFommatter.string(from: self.startDatePicker.date)
        let eDate = dateFommatter.string(from: self.endDatePicker.date)
        delegate.getDate?(sDate: sDate, eDate: eDate)
        self.dismiss(animated: true)
    }
    @IBAction func pressXButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
