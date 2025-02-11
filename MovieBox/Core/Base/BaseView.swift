//
//  BaseView.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureView()
        configureLayout()
    }
    
    func configureHierarchy() {}
    func configureLayout() {}
    func configureView() {
        backgroundColor = .baseBlack
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
