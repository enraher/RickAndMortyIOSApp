//
//  ERSearchInputViewViewModel.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 12/3/23.
//

import Foundation

final class ERSearchInputViewViewModel {
    private let type: ERSearchViewController.Config.`Type`
    
    enum DynamicOption: String {
        case status = "Status"
        case gender = "Gender"
        case locationType = "Location Type"
    }
    
    init(type: ERSearchViewController.Config.`Type`){
        self.type = type
    }
    
    public var hasDynamicOpt: Bool {
        switch self.type {
        case .character, .location:
            return true
        case .episode:
            return false
        }
    }
    
    public var options: [DynamicOption] {
        switch self.type {
        case .character:
            return [.status, .gender]
        case .location:
            return [.locationType]
        case .episode:
            return []
        }
    }
    
    public var serachPlaceHolderText: String {
        switch self.type {
        case .character:
            return "Character Name"
        case .location:
            return "Location Name"
        case .episode:
            return "Episode Title"
        }
    }
}

