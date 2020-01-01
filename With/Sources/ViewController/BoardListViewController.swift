//
//  BoardListViewController.swift
//  With
//
//  Created by 남수김 on 2020/01/01.
//  Copyright © 2020 ns. All rights reserved.
//

import UIKit

class BoardListViewController: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var regionButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    
    var regionString: String = "전체"
    var regionCode = "010000"
    var dateString: String = "날짜"
    
    
    var boardList: [BoardResult] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setDefaultRequest()
    }
    
    func setDefaultRequest() {
        BoardService.shared.getBoardListRequest(code: regionCode) { data in
            guard let list = data else { return }
            self.boardList = list
            self.tableView.reloadData()
            
        }
    }
    
    func setUI() {
        self.topView.dropShadow()
        self.regionButton.layer.borderWidth = 1
        self.dateButton.layer.borderWidth = 1
        self.dateButton.layer.borderColor = UIColor.mainPurple.cgColor
        self.regionButton.layer.borderColor = UIColor.mainPurple.cgColor
        self.regionButton.layer.cornerRadius = 6
        self.dateButton.layer.cornerRadius = 6
        self.dateButton.setTitle(dateString, for: .normal)
        self.regionButton.setTitle(regionString, for: .normal)
        
        self.switchButton.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        self.tableView.dataSource = self
    }
    @IBAction func goToRegionPick(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "RegionFilter") as! RegionFilterViewController
        nextVC.delegate = self
        self.present(nextVC, animated: true)
    }
    @IBAction func goToDatePick(_ sender: Any) {
        let nextVC = UIStoryboard(name: "RegionFilter", bundle: nil).instantiateViewController(withIdentifier: "BoardDatePicker") as! BoardDatePickerViewController
        nextVC.delegate = self
        self.present(nextVC, animated: true)
    }
}

extension BoardListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.boardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoardListCell", for: indexPath) as! BoardListTableViewCell
        cell.viewModel = boardList[indexPath.row]
        return cell
    }
}

extension BoardListViewController: BoardPickDelegate {
    func getDate(sDate: String, eDate: String) {
        self.dateString = "\(sDate) ~ \(eDate)"
        self.dateButton.setTitle(dateString, for: .normal)
        BoardService.shared.getBoardListRequest(code: regionCode, sdate: sDate, edate: eDate) { data in
            guard let list = data else { return }
            self.boardList = list
            self.tableView.reloadData()
            
        }
    }
    func getAllDate() {
        self.dateString = "날짜"
        self.dateButton.setTitle(dateString, for: .normal)
        BoardService.shared.getBoardListRequest(code: regionCode) { data in
            guard let list = data else { return }
            self.boardList = list
            self.tableView.reloadData()
        
        }
    }
}
