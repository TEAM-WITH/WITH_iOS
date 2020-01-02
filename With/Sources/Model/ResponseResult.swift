//
//  NetWorkResult.swift
//  With
//
//  Created by 남수김 on 2019/12/29.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation

struct ResponseResult<T: Codable>: Codable {
    var success: Bool
    var message: String?
    var data: [T]?
}

struct ResponseSimpleResult<T: Codable>: Codable {
    var success: Bool
    var message: String
    var data: T?
}
