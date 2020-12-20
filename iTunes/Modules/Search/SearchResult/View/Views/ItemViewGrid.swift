//
//  ItemViewGrid.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 18/12/2020.
//

import UIKit
import Kingfisher

class ItemViewGrid: AbstractNibView {
    
    // MARK: Properties
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
        
    // MARK: Customise View
    override func customizeView() {
        super.customizeView()
        itemImage.contentMode = .scaleAspectFill
        collectionNameLabel.appStyle(text: "", font: AppFonts.small, textColor: AppColors.black)
    }
    
    /**
     Populate cell with Result
     - parameter result: the result
     */
    public func fillInfo(result: Result) {
        if let urlStr = result.artworkUrl100, urlStr != "" {
            itemImage.kf.setImage(with: URL(string: urlStr))
        }
        collectionNameLabel.text = result.collectionName        
    }
}
