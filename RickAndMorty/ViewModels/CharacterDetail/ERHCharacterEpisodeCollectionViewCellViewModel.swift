//
//  ERHCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 25/2/23.
//

import Foundation

protocol ERHEpisodeDataRender {
    var episode: String { get }
    var name: String { get }
    var air_date: String { get }
}

final class ERHCharacterEpisodeCollectionViewCellViewModel {
    private let episodeDataUrl: URL?
    private var isFetching = false
    private var dataBlock: ((ERHEpisodeDataRender) -> Void)?
    
    private var episode: ERHEpisode? {
        didSet {
            guard let model = episode else {
                return
            }
            dataBlock?(model)
        }
    }
    
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
    
    public func registerForData(_ block: @escaping (ERHEpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        
        guard let url = episodeDataUrl,
              let request = ERHRequest(url: url)
        else { return }
        
        isFetching = true
        ERHService.shared.execute(request, expecting: ERHEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
            case .failure:
                break
            }
        }
    }
}
