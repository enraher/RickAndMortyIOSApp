//
//  ERAPICacheManager.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 26/2/23.
//

import Foundation

final class ERAPICacheManager {
    
    private var cacheDictionary: [
        EREndpoint: NSCache<NSString, NSData>
    ] = [:]
        
    init(){
        setUp()
    }
    
    public func cachedResponse(for endpoint: EREndpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return nil
        }
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endpoint: EREndpoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return
        }
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    private func setUp() {
        EREndpoint.allCases.forEach { endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        }
    }
    
    
}
