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
//       let staticFireDateUTC: String
//       let staticFireDateUnix: Int
//       let tdb, net: Bool
//       let window: Int
//       let rocket: String
//       let success: Bool
//       let details: String
//       let capsules, payloads: [String]
//       let launchpad: String
//       let autoUpdate: Bool
//       let flightNumber: Int
       let name: String
       let dateUTC: String
//       let dateUnix: Int
//       let dateLocal: Date
//       let datePrecision: String
//       let upcoming: Bool
    
    enum CodingKeys: String, CodingKey {
            case name
            case dateUTC = "date_utc"
        }
    
}
