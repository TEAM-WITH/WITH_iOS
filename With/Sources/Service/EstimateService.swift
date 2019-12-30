//
//  EstimateService.swift
//  With
//
//  Created by anhyunjun on 30/12/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import Alamofire

class EstimateService {
    static let shared = EstimateService()
    
    func estimate(_ label: String, completion: @escaping (NetWorkResult<Any>)) -> Void) {
    let header: HTTPHeaders = [
    "Content-Type" : "application/json"
    ]
    let body: Parameters = [
    "label" : label
    ]
    Alamofire.request(API)
    }
}
