//
//  ERHCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 25/2/23.
//

import Foundation
import UIKit


final class ERHCharacterDetailViewViewModel {
    private let character: ERHCharacter
    
    public var episodes: [String] {
        character.episode
    }
    
    enum SectionType {
        case photo(viewModel: ERHCharacterPhotoCollectionViewCellViewModel)
        case information(viewModels: [ERHCharacterInfoCollectionViewCellViewModel])
        case episodes(viewModels: [ERHCharacterEpisodeCollectionViewCellViewModel])
    }
    
    public var sections: [SectionType] = []
    
    init(character: ERHCharacter) {
        self.character = character
        setUpSections()
    }
    
    private func setUpSections() {
//            guard let character = character else {
//                return
//            }
            sections = [
                .photo(viewModel: .init(imageUrl: URL(string: character.image))),
                .information(viewModels: [
                    .init(type: .name, value: character.name),
                    .init(type: .species, value: character.species),
                    .init(type: .gender, value: character.gender.rawValue),
                    .init(type: .status, value: character.status.text),
                    .init(type: .createdAt, value: character.created),
                    .init(type: .origin, value: character.origin.name),
                    .init(type: .type, value: character.type),
                    .init(type: .episodeCount, value: "\(character.episode.count)")
                ]),
                .episodes(viewModels: character.episode.compactMap({
                    return .init(episodeDataUrl: URL(string: $0))
                }))
            ]
        }
    
    public var title: String {
        character.name.uppercased()
    }
    
    public var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    
    // MARK: - LayoutSetUp
    public func createPhotoSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 20,
            leading: 0,
            bottom: 20,
            trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.4)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    public func createInfoSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item, item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createEpisodeSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
