//
//  UserService.swift
//  With
//
//  Created by 남수김 on 2019/12/29.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import Alamofire
struct UserService {
    private init() {}
    static let shared = UserService()
    
    func postSignUpRequest(userData: SignUpModel, completion: @escaping (Bool) -> Void) {
        
        let url = BaseAPI.signUpURL
        
        let header: HTTPHeaders = [
              "Content-Type": "multipart/form-data"
          ]
        
        let body: Parameters = [
            "userId": userData.userId,
            "password": userData.password,
            "name": userData.name ?? "",
            "birth": userData.birth ?? "",
            "gender": userData.gender
        ]
      
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in body {
                if value is String {
                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
                }else if value is Int{
                }
                if let data = userData.userImg {
                    multipartFormData.append(data, withName: "Img", mimeType: "image/jpg")
                }
            }
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: header) { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { _ in
                    completion(true)
                }
            case .failure(_):
                print("fail")
                completion(false)
            }
        }

    }
}
