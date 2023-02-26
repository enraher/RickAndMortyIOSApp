//
//  EREpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 26/2/23.
//

import Foundation


protocol EREpisodeDetailViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}

final class EREpisodeDetailViewViewModel {
    enum ERSectionType {
        case information(viewModels: [EREpisodeInfoCollectionViewCellViewModel])
        case characters(viewModels: [ERCharacterCollectionViewCellViewModel])
    }
    private var dataTuple: (episode: EREpisode, characters: [ERCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchEpisodeDetails()
        }
    }
    private let endpointUrl: URL?
    weak var delegate: EREpisodeDetailViewViewModelDelegate?
    
    public private(set) var cellViewModels: [ERSectionType] = []
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
    }
    
    public func character(at index: Int) -> ERCharacter? {
        guard let dataTuple = dataTuple else {
            return nil
        }
        return dataTuple.characters[index]
    }
    
    public func fetchEpisodeData() {
        guard let url = endpointUrl,
                let request = ERRequest(url: url)
        else { return }

        ERService.shared.execute(request, expecting: EREpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(from: model)
            case .failure:
                break
            }
        }
    }
    
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else {
            return
        }
        
        let episode = dataTuple.episode
        
        var createdString = episode.created
        if let date = ERCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: episode.created) {
            createdString = ERCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
        }
                
        let characters = dataTuple.characters
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Episode Name", value: episode.name),
                .init(title: "Air Date", value: episode.air_date),
                .init(title: "Episode", value: episode.episode),
                .init(title: "Created", value: createdString)
            ]),
            .characters(viewModels: characters.compactMap({ character in
                return ERCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
            }))
        ]
    }
    
    private func fetchRelatedCharacters(from episode: EREpisode) {
        let requests: [ERRequest] = episode.characters.compactMap({
            return URL(string: $0)
        }).compactMap({
            return ERRequest(url: $0)
            
        })

        var characters: [ERCharacter] = []
        let group = DispatchGroup()

        for request in requests {
            group.enter()

            ERService.shared.execute(request, expecting: ERCharacter.self) { result in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure:
                    break
                }
            }
        }

        group.notify(queue: .main) {
            self.dataTuple = (
                episode: episode,
                characters: characters
            )
        }
    }
}
