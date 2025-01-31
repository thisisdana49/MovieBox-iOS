//
//  CustomLabel.swift
//  ImageFinder
//
//  Created by 조다은 on 1/31/25.
//

import UIKit

final class CustomLabel: UILabel {
    
    private var padding = UIEdgeInsets(top: 0.0, left: 4.0, bottom: 0.0, right: 4.0)
    
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
        layoutSubviews()
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        
        return contentSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        self.backgroundColor = .gray3
        self.textColor = .gray1
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
    }
}

