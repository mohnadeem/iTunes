//
//  MediaTypeCell.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 16/12/2020.
//

import UIKit

class MediaTypeCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var mediaTypeView: MediaTypeView!
    
    // MARK: Cell life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    /**
     Populate cell with media type
     - parameter mediaType: the media type
     - parameter isSelected: selected cell
     */
    public func populateCell(mediaType: String, isSelected: Bool) {
        mediaTypeView.fillInfo(mediaType: mediaType, isSelected: isSelected)
    }

}
