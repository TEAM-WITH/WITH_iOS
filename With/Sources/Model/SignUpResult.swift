//
//  SignUpResult.swift
//  With
//
//  Created by 남수김 on 2019/12/29.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation

struct SignUpResult: ResponseResult {
    var status: Int
    var success: Bool
    var message: String
}
