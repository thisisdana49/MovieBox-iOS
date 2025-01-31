//
//  UILabel+Extension.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

extension UILabel {
    
    func calculateNumberOfLines() -> Int {
        let maxSize = CGSize(width: self.frame.width, height: .greatestFiniteMagnitude)
        let text = self.text ?? ""
        let font = self.font ?? UIFont.systemFont(ofSize: 15)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        
        let boundingRect = (text as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        let lineHeight = font.lineHeight
        
        return Int(ceil(boundingRect.height / lineHeight))
    }
    
}
