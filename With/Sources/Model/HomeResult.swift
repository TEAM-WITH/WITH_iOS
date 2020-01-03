//
//  HomeResult.swift
//  With
//
//  Created by 남수김 on 2020/01/03.
//  Copyright © 2020 ns. All rights reserved.
//

import Foundation

//배경받기
struct HomeImg: Codable {
    var regionImgH: String
}

struct HomeRecommendTrip: Codable {
    var regionCode: String
    var regionName: String
    var regionNameEng: String
    var count: Int
    var regionImgS: String
}
