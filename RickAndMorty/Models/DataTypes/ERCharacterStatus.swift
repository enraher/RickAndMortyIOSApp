//
//  ERCharacterStatus.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 24/2/23.
//

import Foundation

enum ERCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
    
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
