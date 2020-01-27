//
//  RegionModel.swift
//  With
//
//  Created by anhyunjun on 30/12/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
struct Region {
    var region: Country
    var data: [Country]
}
struct Country {
    var code: String
    var name: String
    var isClick = false
}
