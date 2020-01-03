//
//  BoardListViewController+Extension.swift
//  With
//
//  Created by 남수김 on 2020/01/02.
//  Copyright © 2020 ns. All rights reserved.
//

import Foundation
import FMDB
extension BoardListViewController {
   
    func setOriginViewAnim() {
        self.view.setNeedsLayout()
        self.searchCancelButton.isHidden = true
        self.searchButton.isEnabled = false
        self.searchView.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.searchAreaRightLayout.constant = 20
            self.topView.alpha = 1
            self.searchView.alpha = 0
            self.searchButton.transform = .identity
            self.searchTextField.transform = .identity
            self.view.layoutIfNeeded()
        }
    }
    
    //검색시 애니메이션
    func setSearchViewAnim() {
        self.view.setNeedsLayout()
        self.searchButton.isEnabled = true
        self.searchCancelButton.isHidden = false
        self.searchView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.searchAreaRightLayout.constant = 70
            self.topView.alpha = 0
            self.searchView.alpha = 1
            self.searchButton.transform = CGAffineTransform(translationX: 230, y: 0)
            self.searchTextField.transform = CGAffineTransform(translationX: -30, y: 0)
            self.view.layoutIfNeeded()
        }
    }
    
    func setDB() {
        fileURL = try! FileManager.default
        .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        .appendingPathComponent("user.sqlite")
        database = FMDatabase(url: fileURL)
    }
    
    func insertQuery(item: String) {
        guard database.open() else {
            print("Unable to open database")
            return
        }
        do {
            try database.executeUpdate("create table if not exists history(id integer, item TEXT)", values: nil)
            if UserDefaults.standard.string(forKey: "dbId") == nil {
                UserDefaults.standard.set("0", forKey: "dbId")
                try database.executeUpdate("insert into history (id, item) values (?, ?)", values: ["0", item])
            }else {
                let dbId = UserDefaults.standard.integer(forKey: "dbId")
                UserDefaults.standard.set("\(dbId+1)", forKey: "dbId")
                try database.executeUpdate("insert into history (id, item) values (?, ?)", values: [dbId, item])
            }
            
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        database.close()
    }
    
    func selectQuery() {
        guard database.open() else {
            print("Unable to open database")
            return
        }
        do {
            let rs = try database.executeQuery("select id, item from history", values: nil)
            self.historyList.removeAll()
            while rs.next() {
                if let item = rs.string(forColumn: "item"), let id = rs.string(forColumn: "id") {
                    let data = SearchData(id: id, item: item)
                    self.historyList.append(data)
                }
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        database.close()
        self.historyList.reverse()
        self.searchHistoryTableView.reloadData()
    }
    
    func deleteAllQuery() {
        guard database.open() else {
            print("Unable to open database")
            return
        }
        do {
            try database.executeUpdate("drop table history", values: nil)
            self.historyList.removeAll()
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        database.close()
    }
    
    func deleteQuery(id: String) {
        guard database.open() else {
            print("Unable to open database")
            return
        }
        do {
            try database.executeUpdate("delete from history where id = \(id)", values: nil)
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        database.close()
    }
}

extension BoardListViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setSearchViewAnim()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchBoard()
        return true
    }
}

struct SearchData {
    var id: String
    var item: String
}
