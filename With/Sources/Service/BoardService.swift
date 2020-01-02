//
//  BoardService.swift
//  With
//
//  Created by 남수김 on 2020/01/02.
//  Copyright © 2020 ns. All rights reserved.
//

import Foundation
import Alamofire
struct BoardService {
    private init() {}
    static let shared = BoardService()
    ///:regionCode/startDates/:startDate/endDates/:endDate/keywords/:keyword/filters/:filter
    
    func getBoardListRequest(code: String, sdate: String = "0", edate: String = "0", word: String = "0", filter: Int = 0, completion: @escaping ([BoardResult]?) -> Void) {
        let token = UserInfo.shared.getUserToken()
        let url = BaseAPI.boardListURL+"/\(code)/startDates/\(sdate)/endDates/\(edate)/keywords/\(word)/filters/\(filter)"
        let header:  HTTPHeaders = [
        "token": token
        ]

        Alamofire.request(url, method: .get, parameters: .none, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            switch response.result {
            case.success:
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(ResponseResult<BoardResult>.self, from: data)
                    if object.success {
                        completion(object.data)
                    } else {
                        completion(nil)
                    }
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case.failure:
                completion(nil)
            }
        }
    }
    
//    func getBoardDetailRequest(boardIdx: Int, completion: @escaping () -> Void) {
//
//    }
}
