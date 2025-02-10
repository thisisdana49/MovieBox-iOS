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
    case searchMovies(keyword: String, page: Int)
    case movieImages(id: String)
    case movieCredits(id: String)
    
    var baseURL: String {
        return Config.baseURL
    }
    
    var endPoint: String {
        switch self {
        case .trendingMovies:
            return baseURL + "/3/trending/movie/day"
        case .searchMovies:
            return baseURL + "/3/search/movie?include_adult=false"
        case .movieImages(let id):
            return baseURL + "/3/movie/\(id)/images"
        case .movieCredits(let id):
            return baseURL + "/3/movie/\(id)/credits"
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
        case .searchMovies(let keyword, let page):
            return [
                "language": "ko-KR",
                "query": keyword,
                "page": page,
            ]
        case .movieImages:
            return [:]
        case .movieCredits:
            return [
                "language": "ko-KR"
            ]
        }
    }
}
