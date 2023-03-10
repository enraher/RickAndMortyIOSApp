//
//  ERLocationDetailViewModel.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 10/3/23.
//


import Foundation

protocol ERLocationDetailViewViewModelDelegate: AnyObject {
    func didFetchLocationDetails()
}

final class ERLocationDetailViewViewModel {
    enum ERSectionType {
        case information(viewModels: [EREpisodeInfoCollectionViewCellViewModel])
        case characters(viewModels: [ERCharacterCollectionViewCellViewModel])
    }
    private var dataTuple: (location: ERLocation, characters: [ERCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchLocationDetails()
        }
    }
    private let endpointUrl: URL?
    weak var delegate: ERLocationDetailViewViewModelDelegate?
    
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
    
    public func fetchLocationData() {
        guard let url = endpointUrl,
                let request = ERRequest(url: url)
        else { return }

        ERService.shared.execute(request, expecting: ERLocation.self) { [weak self] result in
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
        
        let location = dataTuple.location
        let characters = dataTuple.characters
        
        var createdString = location.created
        if let date = ERCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: location.created) {
            createdString = ERCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
        }
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Location Name", value: location.name),
                .init(title: "Type", value: location.type),
                .init(title: "Dimension", value: location.dimension),
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
    
    private func fetchRelatedCharacters(from location: ERLocation) {
        let requests: [ERRequest] = location.residents.compactMap({
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
                location: location,
                characters: characters
            )
        }
    }
}

