//
//  MediaTypesPresenter.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 18/12/2020.
//

import Foundation

class MediaTypesPresenter {
    
    // MARK: Data
    var mediaTypes = ["Album", "Artist", "Book", "Movie", "Music Video", "Podcast", "Song"]    
    var selectedMediaTypes: [String] = []
    
    /**
     Check if a mediaType is exist in the selected media types
     - parameter mediaType: the media type string
     - returns: true/false for existing in
     */
    func isSelected(mediaType: String) -> Bool {
        if selectedMediaTypes.contains(where: {$0 == mediaType}) {
            return true
        }else {
            return false
        }
    }

    /**
     Add or Remove media type from selected list
     - parameter mediaType: the media type string
     */
    func selectDeselectMediaType(mediaType: String) {
        if isSelected(mediaType: mediaType) {
            selectedMediaTypes.removeAll(where: {$0 == mediaType})
        }else {
            selectedMediaTypes.append(mediaType)
        }
    }
}
