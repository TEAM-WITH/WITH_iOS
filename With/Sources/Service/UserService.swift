//
//  UserService.swift
//  With
//
//  Created by 남수김 on 2019/12/29.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import Alamofire
enum NetWorkResult<T, Error>{
    
    case success(T)
    case failure(Error)
    
}
struct UserService {
    private init() {}
    static let shared = UserService()
    
    func postSignUpRequest(imageData: Data?, userData: SignUpModel, completion: @escaping () -> Void) {
        
        let url = BaseAPI.signUpURL
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        
        var parameters: [String : Any]!
        //            "userId"
        //            password: String
        //            salt: String
        //            name: String?
        //            birth: Date?
        //            gender: Bool
        //            userImg: String
        //            hashTag: String?
        //            intro: String?
        //            like: Int?
        //            active: Bool
        parameters["userId"] = userData.userId
        parameters["password"] = userData.password
        parameters["salt"] = userData.salt
        parameters["name"] = userData.name
        parameters["birth"] = userData.birth
        parameters["gender"] = userData.gender
        parameters["userImg"] = userData.userImg
        parameters["hashTag"] = userData.hashTag
        parameters["intro"] = userData.intro
        parameters["like"] = userData.like
        parameters["active"] = userData.active
            
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in parameters {
                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
            }
            if let data = imageData{
                multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
            }
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    guard let data = response.data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let object = try decoder.decode(SignUpResult.self, from: data)
                        print(object)
                    
                    }catch(let err) {
                        print("err")
                    }
                    print("success")
                }
                
                
            case .failure(_):
                print("fail")
            }
        }
        
//        Alamofire.request(url).responseJSON{
//            response in
//
//            switch response.result{
//            case .success:
//
//                guard let data = response.data else {return}
//
//                do{
//                    let decoder = JSONDecoder()
//
//                    let object = try decoder.decode(MemoResult.self, from: data)
//
//                    if object.result == 200{
//                        print("성공")
//                        completion(.success(object.data))
//                    }else {
//                        completion(.failure(fatalError("서버이상")))
//                    }
//
//                }catch(let err){
//                    print(err.localizedDescription)
//                    completion(.failure(err))
//                }
//
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//        }
    }
}
