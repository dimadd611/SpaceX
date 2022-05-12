//
//  Rocket.swift
//  SpaceX
//
//  Created by Dumitru Rahmaniuc on 12.05.2022.
//

import Foundation


struct Rocket: Codable{
    let payloadWeights: [PayloadWeight]
    let name: String
    
    enum CodingKeys: String, CodingKey{
        case payloadWeights = "payload_weights"
        case name
 
    }
}


struct PayloadWeight: Codable {
    let id, name: String
    let kg, lb: Int
}
