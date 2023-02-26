//
//  ERCharacterListView.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 24/2/23.
//

import UIKit

protocol ERCharacterListViewDelegate: AnyObject {
    func erhCharacterListView(_ charaterListView: ERCharacterListView, didSelectCharacter character: ERCharacter)
}

final class ERCharacterListView: UIView {
    
    public weak var delegate: ERCharacterListViewDelegate?
    
    private let viewModel = ERCharacterListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ERCharacterCollectionViewCell.self, forCellWithReuseIdentifier: ERCharacterCollectionViewCell.cellIdentifier)
        collectionView.register(ERFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ERFooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(collectionView, spinner)
        addConstraints()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchCharacters()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
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
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}


extension ERCharacterListView: ERCharacterListViewViewModelDelegate {
    func didLoadInitialCharacters() {
        self.spinner.stopAnimating()
        self.collectionView.isHidden = false
        collectionView.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    func didSelectChararter(_ character: ERCharacter) {
        delegate?.erhCharacterListView(self, didSelectCharacter: character)
    }
    
    func didLoadMoreCharacters(with newIndexPath: [IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPath)
        }
    }
}
