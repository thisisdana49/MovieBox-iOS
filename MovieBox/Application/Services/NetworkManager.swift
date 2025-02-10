//
//  NetworkManager.swift
//  MovieBox
//
//  Created by 조다은 on 1/24/25.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case noInternet
    case timeout
    case unknown
}

enum APIError: Error {
    case authenticationFailed
    case forbidden
    case notFound
    case serverError
    case invalidRequest
    case rateLimitExceeded
    case unknown(statusCode: Int)
    
    init(statusCode: Int) {
        switch statusCode {
        case 400, 422:
            self = .invalidRequest
        case 401:
            self = .authenticationFailed
        case 403:
            self = .forbidden
        case 404:
            self = .notFound
        case 500, 502, 503, 504:
            self = .serverError
        case 429:
            self = .rateLimitExceeded
        default:
            self = .unknown(statusCode: statusCode)
        }
    }
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetchData<T: Decodable>(
        apiRequest: MoiveAPIRequest,
        requestType: T.Type,
        successHandler: @escaping (T) -> Void,
        failureHandler: @escaping (Error) -> Void
    ) {
        AF.request(apiRequest.endPoint,
                   method: apiRequest.method,
                   parameters: apiRequest.parameter,
                   headers: apiRequest.header)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                successHandler(value)
            case .failure:
                if let statusCode = response.response?.statusCode {
                    failureHandler(APIError(statusCode: statusCode))
                } else if let afError = response.error, afError.isSessionTaskError {
                    failureHandler(NetworkError.noInternet)
                } else if let afError = response.error, afError.isResponseSerializationError {
                    failureHandler(NetworkError.timeout)
                } else {
                    failureHandler(NetworkError.unknown)
                }
            }
        }
    }
}
