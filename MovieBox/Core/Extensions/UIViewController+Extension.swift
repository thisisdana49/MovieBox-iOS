//
//  UIViewController+Extension.swift
//  MovieBox
//
//  Created by 조다은 on 2/12/25.
//

import UIKit

enum Screen {
    case search(keyword: String? = nil)
    case searchDetail(movie: Movie)
    case profileSetting(currentNickname: String)
}

extension UIViewController {
    
    func navigate(to screen: Screen, isPresent: Bool = false) {
        let destinationVC: UIViewController
        
        switch screen {
        case .search(let keyword):
            let vc = SearchViewController()
            if let keyword { vc.viewModel.input.keywordTapped.value = keyword }
            destinationVC = vc
            
        case .searchDetail(let movie):
            destinationVC = SearchDetailViewController(movie: movie)
            
        case .profileSetting(let currentNickname):
            destinationVC = ProfileSettingViewController()
        }
        
        if isPresent {
            present(destinationVC, animated: true)
        } else {
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
}
