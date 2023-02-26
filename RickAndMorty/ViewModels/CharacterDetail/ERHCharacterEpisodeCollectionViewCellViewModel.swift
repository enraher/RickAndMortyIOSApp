//
//  ERHCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 25/2/23.
//

import Foundation

final class ERHCharacterEpisodeCollectionViewCellViewModel {
    private let episodeDataUrl: URL?
    private var isFetching = false
//    public var episodeObservable: ObservableObject<ERHEpisode?> = ObservableObject(nil)
    
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
    
    public func fetchEpisode() {
        guard !isFetching,
              let url = episodeDataUrl,
              let request = ERHRequest(url: url)
//                ,
//              episodeObservable.value == nil
        else { return }

        isFetching = true
//        ERHService.shared.execute(request, expected: ERHEpisode.self) { [weak self] result in
//            switch result {
//            case .success(let model):
//                DispatchQueue.main.async {
//                    self?.episodeObservable.value = model
//                }
//            case .failure:
//                break
//            }
//        }
    }
}
