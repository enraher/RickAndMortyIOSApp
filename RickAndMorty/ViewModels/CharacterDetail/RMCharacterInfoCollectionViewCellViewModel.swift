//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 25/2/23.
//

import Foundation
import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    enum `Type` : String {
        case name
        case species
        case gender
        case status
        case createdAt
        case origin
        case type
        case episodeCount

        var tintColor: UIColor {
            switch self {
            case .name:
                return .systemRed
            case .species:
                return .systemBlue
            case .gender:
                return .systemBrown
            case .status:
                return .systemCyan
            case .createdAt:
                return .systemIndigo
            case .origin:
                return .systemBlue
            case .type:
                return .systemMint
            case .episodeCount:
                return .systemTeal
            }
        }
        
        var displayTitle: String {
            switch self {
            case .name,
                 .species,
                 .gender,
                 .status,
                 .origin,
                 .type:
                return rawValue.uppercased()
            case .episodeCount:
                return "Episode count".uppercased()
            case .createdAt:
                return "Create At".uppercased()
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .name:
                return UIImage(systemName: "bell")
            case .species:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")
            case .status:
                return UIImage(systemName: "bell")
            case .createdAt:
                return UIImage(systemName: "bell")
            case .origin:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            case .episodeCount:
                return UIImage(systemName: "bell")
            }
        }
    }

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = .current
        return formatter
    }()

    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    private let type: `Type`
    private var value: String
    
    
    public var title: String {
        return type.displayTitle
    }
    
    public var iconImage: UIImage? {
        return type.iconImage
    }
    
    public var tintColor: UIColor? {
        return type.tintColor
    }

    public var displayValue: String {
        if value.isEmpty {
            return "None"
        }

        if let date = Self.dateFormatter.date(from: value), type == .createdAt {
            return Self.shortDateFormatter.string(from: date)
        }

        return value
    }

    init(type: `Type`,  value: String) {
        self.type = type
        self.value = value
    }
}
