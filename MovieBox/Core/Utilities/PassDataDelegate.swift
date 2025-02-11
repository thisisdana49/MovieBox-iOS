//
//  PassDataDelegate.swift
//  ImageFinder
//
//  Created by 조다은 on 1/23/25.
//

import Foundation

protocol SearchKeywordPassDelegate: AnyObject {
    func didSearchKeyword()
}

protocol ProfileImagePassDelegate: AnyObject {
    func didSelectProfileImage(_ imageIndex: Int)
}

protocol ProfileSettingPassDelegate: AnyObject {
    func didUpdateProfile()
}
