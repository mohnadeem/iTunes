//
//  UIView.swift
//  Classifieds
//
//  Created by Muhammad Nadeem on 21/11/2020.
//

import UIKit

class ClosureSleeve {
    let closure: ()->()
    
    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
}

extension UIView {
    
    /// add **touch up selector** to any **view**
    ///
    /// Usage:
    ///
    ///     view.tapAction{print("View tapped!")}
    ///
    /// - Parameters:
    ///     - closure: The block to be excuted when tapping.
    func tapAction( _ closure: @escaping ()->()){
        self.isUserInteractionEnabled = true
        let sleeve = ClosureSleeve(closure)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: sleeve, action: #selector(ClosureSleeve.invoke))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    /// set corner radius from interface builder
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    /// set border width from interface builder
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    /// set border color from interface builder
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor.init(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}
