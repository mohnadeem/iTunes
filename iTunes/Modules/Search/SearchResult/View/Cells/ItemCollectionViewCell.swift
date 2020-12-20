//
//  ItemCollectionViewCell.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 18/12/2020.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    @IBOutlet weak var itemView: ItemViewGrid!
    
    // MARK: Cell life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    /**
     Populate cell with Result
     - parameter result: the result
     */
    public func populateCell(result: Result) {
        itemView.fillInfo(result: result)
    }

}
