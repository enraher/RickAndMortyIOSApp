//
//  ERCharacter.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 24/2/23.
//

import Foundation

struct ERCharacter: Codable {
    
    let id: Int
    let name: String
    let status: ERCharacterStatus
    let species: String
    let type: String
    let gender: ERCharacterGender
    let origin: EROrigin
    let location: ERSigleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
}

