//
//  ERLocationViewModel.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 9/3/23.
//

import Foundation

final class ERLocationViewModel {
    private var locations: [ERLocation] = []
    
    private var cellViewModels: [String] = []
    
    init() {
        
    }
    
    public func fetchLocations() {
        ERService.shared.execute(.listLocationsRequest, expecting: String.self) { result in
            switch result {
            case .success(let success):
                break
            case .failure(let failure):
                break
            }
        }
    }
    
    private var hasMoreResult: Bool {
        return false
    }
}
