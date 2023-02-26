//
//  ERCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 25/2/23.
//

import Foundation

final class ERCharacterCollectionViewCellViewModel {
    public let characterName: String
    private let characterStatus: ERCharacterStatus
    private let characterImageUrl: URL?
        
    init (
        characterName: String,
        characterStatus: ERCharacterStatus,
        characterImageUrl: URL?
    ) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    public var charaterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        ERImageLoader.shared.downloadImage(from: url, completion: completion)
    }
}


extension ERCharacterCollectionViewCellViewModel:  Hashable, Equatable {
    static func == (lhs: ERCharacterCollectionViewCellViewModel, rhs: ERCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
}
