//
//  ChatService.swift
//  With
//
//  Created by 남수김 on 2020/01/03.
//  Copyright © 2020 ns. All rights reserved.
//

import Foundation
import Alamofire
struct ChatService {
    private init() {}
    static let shared = ChatService()
    
    func getChatListRequest(completion: @escaping ([ChatListResult]?) -> Void) {
        let url = BaseAPI.chatListURL
        let header: HTTPHeaders = [
            "token": UserInfo.shared.getUserToken()
        ]
        Alamofire.request(url, method: .get, parameters: .none, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            switch response.result {
            case.success:
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(ResponseResult<ChatListResult>.self, from: data)
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
    
    func postCreatRoomRequest(completion: @escaping (Bool) -> Void) {
        let url = BaseAPI.chatListURL
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "token": UserInfo.shared.getUserToken()
        ]
        Alamofire.request(url, method: .post, parameters: .none, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            switch response.result {
            case.success:
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(ResponseTempResult.self, from: data)
                    if object.success {
                        completion(true)
                    } else {
                        completion(false)
                    }
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case.failure:
                completion(false)
            }
        }
    }
}
