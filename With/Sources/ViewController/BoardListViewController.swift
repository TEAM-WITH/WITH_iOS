//
//  BoardListViewController.swift
//  With
//
//  Created by 남수김 on 2020/01/01.
//  Copyright © 2020 ns. All rights reserved.
//

import UIKit
import FMDB

class BoardListViewController: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var regionButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchHistoryTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var regionString: String = "전체"
    var regionCode = "010000"
    var dateString: String = "날짜"
    
    
    var boardList: [BoardResult] = []
    var historyList: [SearchData] = []
    
    var fileURL: URL!
    var database: FMDatabase!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // 처음인 경우 지역설정
        if UserInfo.shared.isNotDefaultRegion() {
            let nextVC = UIStoryboard(name: "RegionFilter", bundle: nil).instantiateViewController(withIdentifier: "RegionFilter") as! RegionFilterViewController
            nextVC.delegate = self
            self.present(nextVC, animated: true)
        } else {
            self.regionCode = UserDefaults.standard.string(forKey: "regionCode") ?? "010000"
            self.regionString = UserDefaults.standard.string(forKey: "regionName") ?? "전체"
            self.regionButton.setTitle(regionString, for: .normal)
        }
        setDefaultRequest()
        
        setDB()
    }
    override func viewWillAppear(_ animated: Bool) {
        selectQuery()
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
        self.searchHistoryTableView.dataSource = self
    }
    @IBAction func goToRegionPick(_ sender: Any) {
        let nextVC = UIStoryboard(name: "RegionFilter", bundle: nil).instantiateViewController(withIdentifier: "RegionFilter") as! RegionFilterViewController
        nextVC.delegate = self
        self.present(nextVC, animated: true)
    }
    @IBAction func goToDatePick(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "BoardDatePicker") as! BoardDatePickerViewController
        nextVC.delegate = self
        self.present(nextVC, animated: true)
    }
}

extension BoardListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        if tableView == self.tableView {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView {
            return self.boardList.count
        } else {
            if section == 0 {
                return historyList.count
            } else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BoardListCell", for: indexPath) as! BoardListTableViewCell
            cell.viewModel = boardList[indexPath.row]
            return cell
        } else {
            if indexPath.section == 0 {
                //히스토리
                 let cell = tableView.dequeueReusableCell(withIdentifier: "BoardSearchCell", for: indexPath) as! BoardSearchTableViewCell
                cell.historyLabel.text = self.historyList[indexPath.row].item
                return cell
            } else {
                 let cell = tableView.dequeueReusableCell(withIdentifier: "BoardDeleteCell", for: indexPath) as! BoardDeleteTableCell
                return cell
                
            }
        }
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
    func getRegion(regionCode: String, regionName: String) {
        self.regionCode = regionCode
        self.regionButton.setTitle(regionName, for: .normal)
        UserInfo.shared.setDefaultRegion(regionCode: regionCode, regionName: regionName)
        BoardService.shared.getBoardListRequest(code: regionCode) { data in
            guard let list = data else { return }
            self.boardList = list
            self.tableView.reloadData()
        }
    }
}
