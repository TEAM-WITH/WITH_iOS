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
                upload.responseJSON { response in
                    do {
                        guard let data = response.data else { return }
                        guard let object = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else { return }
                        guard let success = object["success"] as? Bool else { return }
                        if success {
                            print("성공")
                            completion(true)
                        }else {
                            print("통신성공 회원가입실패")
                            completion(false)
                        }
                    } catch(let err) {
                        print(err)
                    }
                }
            case .failure(_):
                print("fail")
                completion(false)
            }
        }

    }
    
    func postLoginRequest(userId: String, pw: String, completion: @escaping (Bool) -> Void) {
        let url = BaseAPI.signUpURL
        
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
                guard let data = response.data else {return}
                do{
                    let decoder = JSONDecoder()
                    
                    let object = try decoder.decode(ResponseResult<LoginResult>.self, from: data)
                    
                    if object.success {
                        print(object.message)
                        completion(true)
                    }else {
                        completion(false)
                    }
                    
                }catch(let err){
                    print(err.localizedDescription)
                    completion(false)
                }
                
            case .failure:
                completion(false)
            }
        }
    }
}
