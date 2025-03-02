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
        case searchKeywords
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

    static func saveSearchKeyword(_ keyword: String) {
        var keywords = getSearchKeywords()
        if keywords.cosntains(keyword) {
            keywords.removeAll { $0 == keyword }
        }
        keywords.insert(keyword, at: 0)

        if keywords.count > 10 {
            keywords.removeLast()
        }
        
        userDefault.setValue(keywords, forKey: Keys.searchKeywords.rawValue)
    }
    
    // search keywords
    static func getSearchKeywords() -> [String] {
        return userDefault.array(forKey: Keys.searchKeywords.rawValue) as? [String] ?? []
    }

    static func removeSearchKeyword(_ keyword: String) {
        var keywords = getSearchKeywords()
        keywords.removeAll { $0 == keyword }
        userDefault.setValue(keywords, forKey: Keys.searchKeywords.rawValue)
    }

    static func clearSearchKeywords() {
        userDefault.removeObject(forKey: Keys.searchKeywords.rawValue)
    }
    
    // liked movie
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
    
    static func clearAll() {
        let domain = Bundle.main.bundleIdentifier!
        userDefault.removePersistentDomain(forName: domain)
        print("초기화 완료!")
    }
}
