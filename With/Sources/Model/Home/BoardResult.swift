//
//  BoardResult.swift
//  With
//
//  Created by 남수김 on 2020/01/02.
//  Copyright © 2020 ns. All rights reserved.
//

import Foundation
struct BoardResult: Codable {
    var boardIdx: Int
    var regionCode: String
    var regionName: String
    var title: String
    var uploadTime: String
    var startDate: String
    var endDate: String
    var withNum: Int
    var filter: Int
    var userImg: String
}
