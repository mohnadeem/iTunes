//
//  MediaTypeView.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 16/12/2020.
//

import UIKit

class MediaTypeView: AbstractNibView {
    
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var checkmarkIV: UIImageView!
        
    // MARK: Customise View
    override func customizeView() {
        super.customizeView()
        bgView.backgroundColor = AppColors.blueDark
        nameLabel.appStyle(text: "", font: AppFonts.small, textColor: AppColors.white)
    }
    
    /**
     Fill in view with media type
     - parameter mediaType: the media type
     */
    public func fillInfo(mediaType: String, isSelected: Bool) {
        nameLabel.text = mediaType
        if isSelected {
            checkmarkIV.isHidden = false
        }else {
            checkmarkIV.isHidden = true
        }
    }
}
