//
//  BaseViewController.swift
//  MovieBox
//
//  Created by 조다은 on 2/11/25.
//

import UIKit

class BaseViewController: UIViewController {

//    var mainView: UIView? = nil
    
//    override func loadView() {
//        view = mainView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
