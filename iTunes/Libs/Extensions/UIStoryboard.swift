//
//  UIStoryboard.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 19/12/2020.
//

import Foundation
import UIKit

extension UIStoryboard {

    /// Main storyboard
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    /// Alert storyboard
    static var alertStoryboard: UIStoryboard {
        return UIStoryboard(name: "Alert", bundle: nil)
    }
}
