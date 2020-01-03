//
//  HomeService.swift
//  With
//
//  Created by 남수김 on 2020/01/03.
//  Copyright © 2020 ns. All rights reserved.
//

import Foundation
import Alamofire
struct HomeService {
    private init() {}
    static let shared = HomeService()

    func getMainImageRequest(completion: @escaping (HomeImg?) -> Void) {
        let url = BaseAPI.homeImgURL
        let header:  HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        Alamofire.request(url, method: .get, parameters: .none, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            switch response.result {
            case.success:
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(ResponseSimpleResult<HomeImg>.self, from: data)
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
    
    func getMainMateRequest(completion: @escaping ([ChatListResult]?) -> Void) {
        let url = BaseAPI.chatListURL
        let token = UserInfo.shared.getUserToken()
        let header: HTTPHeaders = [
            "token": token
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

    func getMainRecommendRequest(regionCode: String, completion: @escaping ([HomeRecommendTrip]?) -> Void) {
        let url = BaseAPI.homeRecommendURL+"/\(regionCode)"
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        Alamofire.request(url, method: .get, parameters: .none, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            switch response.result {
            case.success:
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(ResponseResult<HomeRecommendTrip>.self, from: data)
                    if object.success {
                        print(object.data)
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
    
//    func getMainRecentRequest(regionCode: String, completion: @escaping ([HomeRecent]?) -> Void) {
//        let url = BaseAPI.homeRecentURL+"/\(boardIdx)"
//        let header: HTTPHeaders = [
//            "Content-Type": "application/json"
//        ]
//        Alamofire.request(url, method: .get, parameters: .none, encoding: JSONEncoding.default, headers: header).responseJSON { response in
//            switch response.result {
//            case.success:
//                guard let data = response.data else { return }
//                do {
//                    let decoder = JSONDecoder()
//                    let object = try decoder.decode(ResponseResult<HomeRecent>.self, from: data)
//                    if object.success {
//                        print(object.data)
//                        completion(object.data)
//                    } else {
//                        completion(nil)
//                    }
//                } catch(let err) {
//                    print(err.localizedDescription)
//                }
//            case.failure:
//                completion(nil)
//            }
//        }
//    }
}
