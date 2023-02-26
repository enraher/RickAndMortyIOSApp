//
//  ERCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 25/2/23.
//

import Foundation

protocol EREpisodeDataRender {
    var episode: String { get }
    var name: String { get }
    var air_date: String { get }
}

final class ERCharacterEpisodeCollectionViewCellViewModel {
    private let episodeDataUrl: URL?
    private var isFetching = false
    private var dataBlock: ((EREpisodeDataRender) -> Void)?
    
    private var episode: EREpisode? {
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
    
    public func registerForData(_ block: @escaping (EREpisodeDataRender) -> Void) {
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
              let request = ERRequest(url: url)
        else { return }
        
        isFetching = true
        ERService.shared.execute(request, expecting: EREpisode.self) { [weak self] result in
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

extension ERCharacterEpisodeCollectionViewCellViewModel:  Hashable, Equatable {
    static func == (lhs: ERCharacterEpisodeCollectionViewCellViewModel, rhs: ERCharacterEpisodeCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.episodeDataUrl?.absoluteString ?? "")
    }
}
