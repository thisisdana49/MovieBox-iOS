//
//  MovieRequest.swift
//  MovieBox
//
//  Created by 조다은 on 1/24/25.
//

import Foundation
import Alamofire

enum MoiveAPIRequest {
    case trendingMovies
    
    var baseURL: String {
        return "https://api.themoviedb.org"
    }
    
    var endPoint: String {
        switch self {
        case .trendingMovies:
            return baseURL + "/3/trending/movie/day"
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Bearer \(Key.accessToken)"]
    }
    
    var method: HTTPMethod {
        return .get
        
    }
    
    var parameter: Parameters {
        switch self {
        case .trendingMovies:
            return [
                "language": "ko-KR",
                "page": 1
            ]
        }
    }
}
