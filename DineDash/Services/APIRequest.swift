//
//  APIRequest.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 2.06.2024.
//

import Foundation
import Alamofire

final class APIRequest {
    static let shared = APIRequest()
    
    private init() {}
    
    func get<T: Decodable>(url: String, parameters: [String: Any]? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                completion(response.result)
            }
    }
    
    func post<T: Decodable>(url: String, parameters: [String: Any]? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                completion(response.result)
            }
    }
    
}
