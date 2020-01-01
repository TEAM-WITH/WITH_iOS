//
//  BoardPickDelegate.swift
//  With
//
//  Created by 남수김 on 2020/01/02.
//  Copyright © 2020 ns. All rights reserved.
//

import Foundation
@objc protocol BoardPickDelegate {
    @objc optional func getDate(sDate: String, eDate: String)
    @objc optional func getRegion(regionCode: String, regionName: String)
    @objc optional func getAllDate()
}
