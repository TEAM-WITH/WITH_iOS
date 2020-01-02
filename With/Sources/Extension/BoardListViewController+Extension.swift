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
    struct SearchData {
        var id: Int
        var item: String
    }
    func setOriginViewAnim() {
        
    }
    
    func setSearchViewAnim() {
        
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
            try database.executeUpdate("create table if not exists history(id INTEGER PRIMARY KEY, item TEXT)", values: nil)
            try database.executeUpdate("insert into history (item) values (?)", values: [item])
            
          
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
            let rs = try database.executeQuery("select item from history", values: nil)
            self.historyList.removeAll()
            while rs.next() {
                if let item = rs.string(forColumn: "item"), let id: Int = rs.long(forColumn: "id") {
                    let data = SearchData(id: Int(id) ?? 0, item: item)
                    self.historyList.append(data)
                }
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        database.close()
        self.searchHistoryTableView.reloadData()
    }
    
    func deleteAllQuery() {
        guard database.open() else {
            print("Unable to open database")
            return
        }
        do {
            try database.executeUpdate("drop table history", values: nil)
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
