//
//  iTunesResponse.swift
//  iTunesDemo (iOS)
//
//  Created by Becca Wye on 02/08/2022.
//

import Foundation
import UIKit

struct iTunesResponse: Hashable, Codable {
    var resultCount: Int
    var results : [Track]
    
    struct Track: Hashable, Codable{
        var trackName: String
        var collectionName: String
        var trackCensoredName: String
        var artworkUrl60: String
    }
    
}
