//
//  EREndpoint.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 24/2/23.
//

import Foundation

@frozen enum EREndpoint: String, CaseIterable, Hashable {
    case character
    case location
    case episode
}
