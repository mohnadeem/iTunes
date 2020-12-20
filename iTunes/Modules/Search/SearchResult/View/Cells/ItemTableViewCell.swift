//
//  ItemTableViewCell.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 19/12/2020.
//

import Foundation
import UIKit

class ItemTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var itemView: ItemViewList!
    
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
