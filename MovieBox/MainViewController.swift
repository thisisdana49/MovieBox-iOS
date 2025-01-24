//
//  MainViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/24/25.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.searchPhoto(api: .movieCredits(id: "545611"))
    }

}

