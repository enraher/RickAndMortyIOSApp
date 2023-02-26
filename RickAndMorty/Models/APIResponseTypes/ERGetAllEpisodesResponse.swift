//
//  ERGetAllEpisodesResponse.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 26/2/23.
//

import Foundation

struct ERGetAllEpisodesResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [EREpisode]
}
