//
//  Item.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 19/12/2020.
//

import Foundation

// MARK: - Item
struct Item: Codable {
    let resultCount: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    
    // MARK: Properties
    let artistName: String?
    let collectionName: String?
    let previewURL: String?
    let artworkUrl60: String?
    let artworkUrl100: String?

    enum CodingKeys: String, CodingKey {
        case artistName
        case collectionName
        case previewURL = "previewUrl"
        case artworkUrl60
        case artworkUrl100
    }
}
