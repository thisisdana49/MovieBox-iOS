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
        
        configureView(title: title)
    }
    
    private func configureView(title: String) {
        var config = UIButton.Configuration.borderedTinted()

        var titleAttr = AttributedString.init(title)
        titleAttr.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        config.attributedTitle = titleAttr
        
        config.baseBackgroundColor = .baseBlack
        config.baseForegroundColor = .mainBlue
        
        config.cornerStyle = .capsule
        config.background.strokeWidth = 2
        config.background.strokeColor = .mainBlue
        
        configuration = config
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
