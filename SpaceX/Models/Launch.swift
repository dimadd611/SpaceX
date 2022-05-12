//
//  Launch.swift
//  SpaceX
//
//  Created by Dumitru Rahmaniuc on 11.05.2022.
//

import Foundation


//struct LaunchResponse: Codable{
////    let results: [Launch]
//}


struct Launch: Codable{
    let links: Links
//       let staticFireDateUTC: String
//       let staticFireDateUnix: Int
//       let tdb, net: Bool
//       let window: Int
       let rocket: String
//       let success: Bool
       let details: String?
//       let launchpad: String
//       let autoUpdate: Bool
//       let flightNumber: Int
       let name: String
       let dateUnix: Int
//       let dateLocal: Date
//       let datePrecision: String
//       let upcoming: Bool
    
    enum CodingKeys: String, CodingKey {
            case links = "links"
            case name
            case dateUnix = "date_unix"
            case rocket = "rocket"
            case details = "details"
            
        
        
        
        }
    
}

struct Links: Codable {
    let patch: Patch
    let flickr: Flickr
    let youtubeID: String?
    let wiki: String?
    enum CodingKeys: String, CodingKey{
        case patch = "patch"
        case flickr = "flickr"
        case youtubeID = "youtube_id"
        case wiki = "wikipedia"
    }
}


struct Patch: Codable {
    let small: String?
    
    enum CodingKeys: String, CodingKey{
        case small = "small"
    }
}


struct Flickr: Codable{
    let original: [String]?
    
    enum CodingKeys: String, CodingKey{
        case original = "original"
    }
}
