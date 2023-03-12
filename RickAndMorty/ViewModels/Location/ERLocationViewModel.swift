//
//  ERLocationViewModel.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 9/3/23.
//

import Foundation

protocol ERLocationViewModelDelegate: AnyObject {
    func didFecthInitialLocation()
    func didLoadMoreLocations(with newIndexPath: [IndexPath])
}

final class ERLocationViewModel {
    
    weak var delegate: ERLocationViewModelDelegate?
    public private(set) var isLoadingMoreLocations = false
    
    private var locations: [ERLocation] = [] {
        didSet {
            for location in locations {
                let cellViewModel = ERLocationTableViewCellViewModel(location: location)
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
    private var apiInfo: ERGetAllLocationsResponse.Info?
    
    public private(set) var cellViewModels: [ERLocationTableViewCellViewModel] = []
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    init() {
        
    }
    
    public func location(at index: Int) -> ERLocation? {
        guard index < locations.count, index >= 0 else {
            return nil
        }
        return self.locations[index]
    }
    
    public func getNextUrl() -> URL? {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreLocations,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
            return nil
        }
        return url
    }
    
    public func fetchLocations() {
        ERService.shared.execute(
            .listLocationsRequest,
            expecting: ERGetAllLocationsResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let success):
                self?.apiInfo = success.info
                self?.locations = success.results
                DispatchQueue.main.async {
                    self?.delegate?.didFecthInitialLocation()
                }                
                break
            case .failure(let failure):
                break
            }
        }
    }
    
    public func fetchAdditionalLocations(url: URL) {
        guard !isLoadingMoreLocations else {
            return
        }
        isLoadingMoreLocations = true
        guard let request = ERRequest(url: url) else {
            return
        }
        
        ERService.shared.execute(request, expecting: ERGetAllLocationsResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
                let moreResult = responseModel.results
                strongSelf.apiInfo = responseModel.info
                let originalCount = strongSelf.locations.count
                let newCount = moreResult.count
                let total = originalCount + newCount
                let startingIdex = total - newCount
                let indexPathToAdd: [IndexPath] = Array(startingIdex..<(startingIdex+newCount)).compactMap {
                    return IndexPath(row: $0, section: 0)
                }
                strongSelf.locations.append(contentsOf: moreResult)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreLocations(with: indexPathToAdd)
                    strongSelf.isLoadingMoreLocations = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                strongSelf.isLoadingMoreLocations = false
            }
        }
    }
    
    
    private var hasMoreResult: Bool {
        return false
    }
}
