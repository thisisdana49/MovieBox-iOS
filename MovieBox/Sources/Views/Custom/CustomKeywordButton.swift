//
//  CustomKeywordButton.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

class CustomKeywordButton: UIButton {
    
    var title: String = ""
    
    init(title: String) {
        super.init(frame: .zero)
        
        var config = UIButton.Configuration.filled()

        var titleAttr = AttributedString.init(title)
        titleAttr.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        config.attributedTitle = titleAttr
        
        config.baseBackgroundColor = .baseWhite
        config.baseForegroundColor = .baseBlack
        
        config.image = UIImage(systemName: "xmark")
        config.imagePadding = 10
        config.imagePlacement = .trailing
        
        config.buttonSize = .small
        config.cornerStyle = .capsule
        
        self.configuration = config
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
