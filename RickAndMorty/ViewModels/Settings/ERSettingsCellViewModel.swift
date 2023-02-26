//
//  ERERSettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 26/2/23.
//

import UIKit

struct ERSettingsCellViewModel: Identifiable {
    let id = UUID()
    
    public let type: ERSettingsOption
    public let onTapHandler: (ERSettingsOption) -> Void
    
    init(type: ERSettingsOption, onTapHandler: @escaping (ERSettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
    }
    
    public var image: UIImage? {
        return type.iconImage
    }
    
    public var title: String {
        return type.displayTitle
    }
    
    public var iconContainerColor: UIColor {
        return type.iconContainerColor
    }
   
}
