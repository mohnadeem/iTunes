//
//  ItemViewList.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 19/12/2020.
//

import UIKit
import Kingfisher

class ItemViewList: AbstractNibView {
    
    // MARK: Properties
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
        
    // MARK: Customise View
    override func customizeView() {
        super.customizeView()
        bgView.backgroundColor = #colorLiteral(red: 0.4156862745, green: 0.5058823529, blue: 0.568627451, alpha: 1)
        itemImage.contentMode = .scaleAspectFill
        collectionNameLabel.appStyle(text: "", font: AppFonts.smallBold, textColor: AppColors.white)
        artistNameLabel.appStyle(text: "", font: AppFonts.small, textColor: AppColors.white)
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
        artistNameLabel.text = result.artistName
    }
}
