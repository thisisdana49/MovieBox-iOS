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
        // notifications
        // alert
    }
    
    static let userDefault = UserDefaults.standard
    
    static func set<T>(to: T, forKey: Self.Keys) {
        userDefault.setValue(to, forKey: forKey.rawValue)
        print("UserDefaultsManager: save \(forKey) complete")
    }
    
    static func get(forKey: Self.Keys) -> Any? {
        return userDefault.object(forKey: forKey.rawValue)
    }
}
