//
//  Services.swift
//  BookYourGift
//
//  Created by Apple on 03/08/23.
//

import Foundation
import Alamofire
import SwiftyJSON
class BYGServices {
    class func postService(url: String, parameters: [String: Any], headers: HTTPHeaders, success: @escaping (JSON) -> Void, failure: @escaping
                           (Error) -> Void) {
        
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseData { response in
            switch response.result {
            case .success:
                let resJSON = JSON(response.value!)
                print(resJSON)
                success(resJSON)
            case .failure(let error):
                print(error)
                failure(error)
            }
            
        }
    }
    class func getService(url: String, parameters: [String: Any], headers: HTTPHeaders, success: @escaping (JSON) -> Void, failure: @escaping (Error) -> Void) {
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default ,headers: headers).responseData { response in
            switch response.result {
            case .success:
                let resJSON = JSON(response.value!)
                print(resJSON)
                success(resJSON)
            case .failure(let error):
                print(error)
                failure(error)
            }
        }
    }
}
