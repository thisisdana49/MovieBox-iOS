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
    
    func searchPhoto(api: MoiveAPIRequest) {
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, headers: api.header).responseString { response in
            dump(response)
        }
    }
}
