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
    
    func searchMovie<T: Decodable>(
        api: MoiveAPIRequest,
        type: T.Type
    ) {
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, headers: api.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                dump(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
