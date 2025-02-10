//
//  BaseViewModel.swift
//  MovieBox
//
//  Created by 조다은 on 2/10/25.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform()
}
