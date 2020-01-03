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
        
        let body: [String: String] = [
            "userId": userData.userId,
            "password": userData.password,
            "name": userData.name ?? "",
            "birth": userData.birth ?? "",
            "gender": "\(userData.gender)"
        ]
      
        print(userData)
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in body {
                
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            if let data = userData.userImg {
                multipartFormData.append(data, withName: "Img", mimeType: "image/jpg")
            }
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: header) { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                  
                    do {
                        guard let data = response.data else { return }
                        
                        let decoder = JSONDecoder()
                        let object = try decoder.decode(ResponseTempResult.self, from: data)
                        
                        if object.success {
                            completion(true)
                        }else {
                            completion(false)
                        }
                    } catch(let err) {
                        print(err)
                    }
                }
            case .failure(_):
                completion(false)
            }
        }

    }
    
    func postLoginRequest(userId: String, pw: String, completion: @escaping (LoginResult?) -> Void) {
        let url = BaseAPI.logInURL
        let header: HTTPHeaders = [
              "Content-Type": "application/json"
          ]
        let body: Parameters = [
            "userId": userId,
            "password": pw
        ]
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do{
                    let decoder = JSONDecoder()
                    
                    let object = try decoder.decode(LoginResult.self, from: data)
                    if object.success {
                        guard let token = object.data?.token else { return }
                        guard let userIdx = object.data?.userIdx else { return }
                        UserInfo.shared.setUserInfo(token: token, userIdx: userIdx)
                        
                        completion(object)
                    }else {
                        completion(object)
                    }
                    
                }catch(let err){
                    print(err.localizedDescription)
                    completion(nil)
                }
                
            case .failure:
                completion(nil)
            }
        }
    }
}
