//
//  NetworkManager.swift
//  MovieBox
//
//  Created by 조다은 on 1/24/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetchData<T: Decodable>(
        apiRequest: MoiveAPIRequest,
        requestType: T.Type,
        successHandler: @escaping (T) -> Void
    ) {
        AF.request(apiRequest.endPoint,
                   method: apiRequest.method,
                   parameters: apiRequest.parameter,
                   headers: apiRequest.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
//                dump(value)
                successHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
