//
//  UserDefaultsManager.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import Foundation

struct UserDefaultsManager {
    
    enum Keys: String {
        // app start
        case isFirst
        case userNickname
        case joinDate
        case profileImage
        case likedMovies
        // notifications
        // alert
    }
    
    static let userDefault = UserDefaults.standard
    
    static func set<T>(to: T, forKey: Self.Keys) {
        userDefault.setValue(to, forKey: forKey.rawValue)
        print("UserDefaultsManager: save \(to) in \(forKey) complete")
    }
    
    static func get(forKey: Self.Keys) -> Any? {
        return userDefault.object(forKey: forKey.rawValue)
    }
    
    static func saveLikedMovie(_ movieID: Int) {
        var likedMovies = getLikedMovies()
        if !likedMovies.contains(movieID) {
            likedMovies.append(movieID)
        }
        userDefault.setValue(likedMovies, forKey: Keys.likedMovies.rawValue)
        print(#function, likedMovies)
    }
    
    static func getLikedMovies() -> [Int] {
        return userDefault.array(forKey: Keys.likedMovies.rawValue) as? [Int] ?? []
    }
    
    static func removeLikedMovie(_ movieID: Int) {
        var likedMovies = getLikedMovies()
        likedMovies.removeAll { $0 == movieID }
        userDefault.setValue(likedMovies, forKey: Keys.likedMovies.rawValue)
    }
    
    static func isLikedMovie(_ movieID: Int) -> Bool {
        return getLikedMovies().contains(movieID)
    }
}
