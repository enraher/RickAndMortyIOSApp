//
//  ERHEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 26/2/23.
//

import Foundation


protocol ERHEpisodeDetailViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}

final class ERHEpisodeDetailViewViewModel {
//    enum SectionType {
//        case information(viewModels: [EpisodeInfoCollectionViewCellViewModel])
//        case characters(viewModels: [CharacterCollectionViewCellViewModel])
//    }
    
    private let endpointUrl: URL?
//    weak var delegate: EpisodeDetailViewViewModelDelegate?
//    public private(set) var sections: [SectionType] = []
//
//    private var dataTuple: (Episode, [Character])? {
//        didSet {
//            delegate?.didFetchEpisodeDetails()
//        }
//    }
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
        fetchEpisodeData()
    }
    
    public func fetchEpisodeData() {
        guard let url = endpointUrl,
                let request = ERHRequest(url: url)
        else { return }

        ERHService.shared.execute(request, expecting: ERHEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(from: model)
            case .failure:
                break
            }
        }
    }
    
    private func fetchRelatedCharacters(from episode: ERHEpisode) {
//        let charactersOnEpisode: [URL] = episode.characters.compactMap({ return URL(string: $0) })
//        let requests: [RMRequest] = charactersOnEpisode.compactMap({ return RMRequest(url: $0) })
//
//        var characters: [Character] = []
//        let group = DispatchGroup()
//
//        for request in requests {
//            group.enter()
//
//            Service.shared.execute(request, expecting: Character.self) { result in
//                defer {
//                    group.leave()
//                }
//                switch result {
//                case .success(let model):
//                    characters.append(model)
//                case .failure:
//                    break
//                }
//            }
//        }
//
//        group.notify(queue: .main) {
//            self.dataTuple = (episode, characters)
//        }
    }
}
