//
//  MainViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/24/25.
//

import UIKit

class MainViewController: UIViewController {

    let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.fetchData(apiRequest: .trendingMovies, requestType: MovieListResponse.self)
    }
}

