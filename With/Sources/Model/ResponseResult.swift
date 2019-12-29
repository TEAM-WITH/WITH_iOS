//
//  NetWorkResult.swift
//  With
//
//  Created by 남수김 on 2019/12/29.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation

protocol ResponseResult: Codable {
    var status: Int { get set }
    var success: Bool { get set }
    var message: String { get set }
}
