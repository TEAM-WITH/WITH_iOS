//
//  EstimateService.swift
//  With
//
//  Created by anhyunjun on 30/12/2019.
//  Copyright © 2019 ns. All rights reserved.
//
//
//import Foundation
//import Alamofire
//
//struct EstimateService {
//    private init() {}
//    static let shared = EstimateService()
//
//    func estimateRequest(_ label: String, completion: @escaping (Bool) -> Void) {
//        let url = BaseAPI.baseURL
//        let header: HTTPHeaders = [
//        "Content-Type" : "application/json"
//        ]
//        let body: Parameters = [
//            "label" : label
//        ]
//        Alamofire.request(url).responseJSON { data in
//            data.
//        }
//
//        completion(true)
//    }
//}
