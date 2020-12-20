//
//  UIButton.swift
//  Classifieds
//
//  Created by Muhammad Nadeem on 21/11/2020.
//

import Foundation
import UIKit

extension UIButton {
    
    /// Customize button style with background and text colors
    func appStyle(title: String, font: UIFont, textColor: UIColor = AppColors.white, bgColor: UIColor = UIColor.clear, borderColor: UIColor = UIColor.clear, borderWidth: CGFloat = 1, cornerRadius: CGFloat = 0, isReversedColors: Bool = false) {
        if bgColor != .clear {
            self.layer.cornerRadius = 6
        }
        if cornerRadius > 0 {
            self.layer.cornerRadius = cornerRadius
        }
        self.layer.borderColor = borderColor.cgColor
        if borderColor != .clear {
            self.layer.borderWidth = borderWidth
        }
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.clear
        setTitle(title, for: .normal)
        setTitle(title, for: .highlighted)
        setTitle(title, for: .selected)
        titleLabel?.font = font
        setTitleColor(textColor, for: .normal)
        setTitleColor(textColor, for: .highlighted)
        setTitleColor(textColor, for: .selected)
        
        // reversed highlight colors
        if isReversedColors {
            setTitleColor(bgColor, for: .highlighted)
            setTitleColor(bgColor, for: .selected)
        }
    }
    
    /// Align the image and title verticallt in the button
    func alignImageAndTitleVertically(padding: CGFloat = 6.0) {
        
        let imageSize = self.imageView!.frame.size
        let titleSize = self.titleLabel!.frame.size
        let totalHeight = imageSize.height + titleSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageSize.height),
            left: 0,
            bottom: 0,
            right: -titleSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageSize.width,
            bottom: -(totalHeight - titleSize.height),
            right: 0
        )
    }
    
}
