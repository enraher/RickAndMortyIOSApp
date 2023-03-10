//
//  ERSettingsView.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 26/2/23.
//

import SwiftUI

struct ERSettingsView: View {
    let viewModel: ERSettingsViewViewModel
    
    init(viewModel: ERSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewModels) {
            cellViewModel in
            HStack
            {
                if let image = cellViewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                        .padding(5)
                        .background(Color(cellViewModel.iconContainerColor))
                        .cornerRadius(4)
                }
                Text(cellViewModel.title)
                .padding(.leading, 10)
                Spacer()
            }
            .frame(height: 40)
            .contentShape(Rectangle())
            .onTapGesture {
                cellViewModel.onTapHandler(cellViewModel.type)
            }
        }
    }
}

struct ERSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ERSettingsView(viewModel: .init(cellViewModels: ERSettingsOption.allCases.compactMap({ setOp in
            return ERSettingsCellViewModel.init(type: setOp) { option in
                
            }
        })))
    }
}
