//
//  UIImage.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 19/12/2020.
//

import UIKit

extension UIImage {
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    convenience init?(withContentsOfUrl url: URL) throws {
        let imageData = try Data(contentsOf: url)
        self.init(data: imageData)
    }
}
