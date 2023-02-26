//
//  ERCharacterDetailView.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 25/2/23.
//

import UIKit

class ERCharacterDetailView: UIView {

    public var collectionView: UICollectionView?
    
    private let viewModel: ERCharacterDetailViewViewModel
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    init(frame: CGRect, viewModel: ERCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubviews(collectionView, spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints(){
        guard let collectionView = collectionView else {
            return
        }
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    
        ])
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout{ sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ERCharacterPhotoCollectionViewCell.self, forCellWithReuseIdentifier: ERCharacterPhotoCollectionViewCell.cellIdentifier)
        collectionView.register(ERCharacterInfoCollectionViewCell.self, forCellWithReuseIdentifier: ERCharacterInfoCollectionViewCell.cellIdentifier)
        collectionView.register(ERCharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: ERCharacterEpisodeCollectionViewCell.cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch viewModel.sections[sectionIndex] {
                case .photo:
                    return viewModel.createPhotoSection()
                case .information:
                    return viewModel.createInfoSection()
                case .episodes:
                    return viewModel.createEpisodeSection()
                }
    }
    

}
