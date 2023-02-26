//
//  ERService.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 24/2/23.
//

import Foundation


final class ERService {
    
    private let cacheManager = ERAPICacheManager()
    
    static let shared = ERService()
    
    private init() {}
    
    enum ERServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    public func execute<T: Codable>(
        _ request: ERRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
        if let cachedData = cacheManager.cachedResponse(for: request.endpoint, url: request.url) {
            do {
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
            return
        }
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ERServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) {
            data, _, error in
            guard let data = data , error == nil else {
                completion(.failure(ERServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                self.cacheManager.setCache(for: request.endpoint, url: request.url, data: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
    
    private func request(from rmRequest: ERRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}
