//
//  ERSearchView.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 12/3/23.
//

import UIKit

final class ERSearchView: UIView {
    
    private let viewModel: ERSearchViewViewModel
    
    private let noResultView = ERNoSearchResultsView()
    
    init(frame: CGRect, viewModel: ERSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(noResultView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            noResultView.heightAnchor.constraint(equalToConstant: 150),
            noResultView.widthAnchor.constraint(equalToConstant: 150),
            noResultView.centerYAnchor.constraint(equalTo: centerYAnchor),
            noResultView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
}

extension ERSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
