//
//  EREpisodeListViewViewModel.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 26/2/23.
//

import Foundation
import UIKit

protocol EREpisodeListViewViewModelDelegate: AnyObject {
    func didLoadInitialEpisodes()
    func didSelectEpisode(_ episode: EREpisode)
    func didLoadMoreEpisodes(with newIndexPath: [IndexPath])
}

final class EREpisodeListViewViewModel: NSObject {
    
    public weak var delegate: EREpisodeListViewViewModelDelegate?
    
    private var isLoadingMoreEpisodes = false
    
    private var episodes: [EREpisode] = [] {
        didSet {
            for episode in episodes {
                let viewModel = ERCharacterEpisodeCollectionViewCellViewModel(
                    episodeDataUrl: URL(string: episode.url))
                
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [ERCharacterEpisodeCollectionViewCellViewModel] = []
    
    private var apiInfo: ERGetAllEpisodesResponse.Info? = nil
    
    public func fetchEpisodes() {
        ERService.shared.execute(
            .listEpisodesRequest,
            expecting: ERGetAllEpisodesResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.apiInfo = responseModel.info
                self?.episodes = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialEpisodes()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public func fetchAdditionalEpisodes(url: URL) {
        guard !isLoadingMoreEpisodes else {
            return
        }
        isLoadingMoreEpisodes = true
        guard let request = ERRequest(url: url) else {
            return
        }
        
        ERService.shared.execute(request, expecting: ERGetAllEpisodesResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
                let moreResult = responseModel.results
                strongSelf.apiInfo = responseModel.info
                let originalCount = strongSelf.episodes.count
                let newCount = moreResult.count
                let total = originalCount + newCount
                let startingIdex = total - newCount
                let indexPathToAdd: [IndexPath] = Array(startingIdex..<(startingIdex+newCount)).compactMap {
                    return IndexPath(row: $0, section: 0)
                }
                strongSelf.episodes.append(contentsOf: moreResult)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreEpisodes(with: indexPathToAdd)
                    strongSelf.isLoadingMoreEpisodes = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                strongSelf.isLoadingMoreEpisodes = false
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
}


extension EREpisodeListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ERCharacterEpisodeCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? ERCharacterEpisodeCollectionViewCell else {
            fatalError("Unsopported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = bounds.width - 20
        return CGSize(width: width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let episode = episodes[indexPath.row]
        delegate?.didSelectEpisode(episode)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ERFooterLoadingCollectionReusableView.identifier,
                for: indexPath
              ) as? ERFooterLoadingCollectionReusableView else {
            fatalError("unsopported")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

extension EREpisodeListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreEpisodes,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
            return
        }
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self.fetchAdditionalEpisodes(url: url)
            }
    }
}
