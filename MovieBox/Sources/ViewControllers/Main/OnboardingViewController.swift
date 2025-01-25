//
//  OnboardingViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

class OnboardingViewController: UIViewController {

    var isFirst = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserDefaultsManager.set(to: isFirst, forKey: .isFirst)
    }
    
}
