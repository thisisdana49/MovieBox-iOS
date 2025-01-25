//
//  CustomButton.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

class CustomButton: UIButton {
    
    var title: String = ""
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(.mainBlue, for: .normal)
        backgroundColor = .black
        layer.borderColor = UIColor.mainBlue.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 20
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
