//
//  CustomTextField.swift
//  ImageFinder
//
//  Created by 조다은 on 1/31/25.
//

import UIKit

final class CustomTextField: UITextField {
    
    var textPadding = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
}
