//
//  ERCharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 24/2/23.
//

import UIKit

protocol ERCharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didSelectChararter(_ character: ERCharacter)
    func didLoadMoreCharacters(with newIndexPath: [IndexPath])
}

final class ERCharacterListViewViewModel: NSObject {
    
    public weak var delegate: ERCharacterListViewViewModelDelegate?
    
    private var isLoadingMoreCharacters = false
    
    private var characters: [ERCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = ERCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image))
                
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [ERCharacterCollectionViewCellViewModel] = []
    
    private var apiInfo: ERGetAllCharactersResponse.Info? = nil
    
    public func fetchCharacters() {
        ERService.shared.execute(
            .listCharactersRequest,
            expecting: ERGetAllCharactersResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.apiInfo = responseModel.info
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public func fetchAdditionalCharacters(url: URL) {
        guard !isLoadingMoreCharacters else {
            return
        }
        isLoadingMoreCharacters = true
        guard let request = ERRequest(url: url) else {
            return
        }
        
        ERService.shared.execute(request, expecting: ERGetAllCharactersResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
                let moreResult = responseModel.results
                strongSelf.apiInfo = responseModel.info
                let originalCount = strongSelf.characters.count
                let newCount = moreResult.count
                let total = originalCount + newCount
                let startingIdex = total - newCount
                let indexPathToAdd: [IndexPath] = Array(startingIdex..<(startingIdex+newCount)).compactMap {
                    return IndexPath(row: $0, section: 0)
                }
                strongSelf.characters.append(contentsOf: moreResult)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacters(with: indexPathToAdd)
                    strongSelf.isLoadingMoreCharacters = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                strongSelf.isLoadingMoreCharacters = false
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
}


extension ERCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ERCharacterCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? ERCharacterCollectionViewCell else {
            fatalError("Unsopported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30)/2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectChararter(character)
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

extension ERCharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacters,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchAdditionalCharacters(url: url)
            }
            t.invalidate()
        }
        
    }
}
