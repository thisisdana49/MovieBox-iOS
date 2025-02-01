//
//  Movie.swift
//  MovieBox
//
//  Created by 조다은 on 1/24/25.
//

import Foundation

struct MovieListResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Codable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let genreIds: [Int]
    let releaseDate: String
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
    let adult: Bool
    let originalLanguage: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, popularity
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case adult
        case originalLanguage = "original_language"
    }
}

extension Movie {
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "\(Config.imageBaseURL)w500/\(path)")
    }
}

struct MovieCredit: Codable {
    let cast: [MovieCast]
}

struct MovieCast: Codable {
    let name: String
    let originalName: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case originalName = "original_name"
        case profilePath = "profile_path"
    }
}

extension MovieCast {
    var profileURL: URL? {
        if let profilePath {
            return URL(string: "\(Config.imageBaseURL)w500/\(profilePath)")
        } else {
            return nil
        }
    }
}

struct MovieImage: Codable {
    let backdrops: [MovieImageDetail]
    let posters: [MovieImageDetail]
}

struct MovieImageDetail: Codable {
    let aspectRatio: Double
    let height: Int
    let width: Int
    let filePath: String
    
    enum CodingKeys: String, CodingKey {
        case height, width
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
    }
}

extension MovieImageDetail {
    var imageURL: URL? {
        return URL(string: "\(Config.imageBaseURL)original/\(filePath)")
    }
}
