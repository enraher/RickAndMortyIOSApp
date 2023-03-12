//
//  ERSearchInputView.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 12/3/23.
//

import UIKit

final class ERSearchInputView: UIView {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private var viewModel: ERSearchInputViewViewModel? {
        didSet {
            guard let viewModel = viewModel, viewModel.hasDynamicOpt else {
                return
            }
            let options = viewModel.options
            createOptionSelectionViews(options: options)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubviews(searchBar)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor),
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func createOptionSelectionViews(options: [ERSearchInputViewViewModel.DynamicOption]) {
        for option in options {
            
        }
    }
    
    public func configure(with viewModel: ERSearchInputViewViewModel) {
        self.viewModel = viewModel
        searchBar.placeholder = viewModel.serachPlaceHolderText
    }
}
