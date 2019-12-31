//
//  CountryService.swift
//  With
//
//  Created by anhyunjun on 31/12/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import Alamofire

struct CountryService {
    private init() {}
    static let shared = CountryService()
    
    func getCountryRequest(regionCode: String, completion:@escaping ([CountryModel]?) -> Void) {
        
        let url = BaseAPI.regionCodeURL+regionCode
        let header:  HTTPHeaders = [
        "Content-Type": "application/json"
        ]
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case.success:
                do {
                guard let data = response.data else { return }
                let decoder = JSONDecoder()
                    let object = try decoder.decode(ResponseResult<CountryModel>.self, from: data)
                    
                    completion(object.data)
                } catch(let err) {
                    print(err)
                    completion(nil)
                }
                
            case.failure:
                print("err")
                completion(nil)
            }
        }
    }
}
