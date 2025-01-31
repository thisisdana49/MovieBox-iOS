//
//  PassDataDelegate.swift
//  ImageFinder
//
//  Created by 조다은 on 1/23/25.
//

import Foundation

protocol PassDataDelegate: AnyObject {
    func didSearchKeyword(_ keyword: String)
}
