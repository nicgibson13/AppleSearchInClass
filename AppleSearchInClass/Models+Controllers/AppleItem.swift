//
//  AppleItem.swift
//  AppleSearchInClass
//
//  Created by Nic Gibson on 6/27/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import UIKit

struct TopLevelJSON: Decodable {
    let results: [AppleItem]
}

struct AppleItem: Decodable {
    let track: String
    let artist: String
    let album: String
    let imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case track = "trackName"
        case artist = "artistName"
        case album = "collectionName"
        case imageURL = "artworkUrl30"
    }
}
