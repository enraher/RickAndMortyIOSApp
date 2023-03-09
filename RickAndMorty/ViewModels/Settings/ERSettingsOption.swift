//
//  ERERSettingsOption.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 26/2/23.
//

import UIKit

enum ERSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewCode
    
    var targetUrl: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://www.linkedin.com/in/enraher/")
        case .terms:
            return nil
        case .privacy:
            return nil
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com")
        case .viewCode:
            return URL(string: "https://github.com/enraher/RickAndMortyIOSApp")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Me"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privasy Policy"
        case .apiReference:
            return "API Reference"
        case .viewCode:
            return "View Code"
        }
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemRed
        case .contactUs:
            return .systemMint
        case .terms:
            return .systemTeal
        case .privacy:
            return .systemBlue
        case .apiReference:
            return .systemBrown
        case .viewCode:
            return .systemCyan
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane")
        case .terms:
            return UIImage(systemName: "doc")
        case .privacy:
            return UIImage(systemName: "lock")
        case .apiReference:
            return UIImage(systemName: "list.clipboard")
        case .viewCode:
            return UIImage(systemName: "hammer")
        }
    }
}
