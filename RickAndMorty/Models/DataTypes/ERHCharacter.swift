//
//  ERHCharacter.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 24/2/23.
//

import Foundation

struct ERHCharacter: Codable {
    
    let id: Int
    let name: String
    let status: ERHCharacterStatus
    let species: String
    let type: String
    let gender: ERHCharacterGender
    let origin: ERHOrigin
    let location: ERHSigleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
}

