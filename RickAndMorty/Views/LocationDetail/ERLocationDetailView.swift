//
//  ERLocationDetailView.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 10/3/23.
//


import UIKit

protocol ERLocationDetailViewDelegate: AnyObject{
    func erhLocationDetailView(_ detailView: ERLocationDetailView,
                             didSelect character: ERCharacter
    )
}

final class ERLocationDetailView: UIView {

    public weak var delegate: ERLocationDetailViewDelegate?
    
    private var viewModel: ERLocationDetailViewViewModel? {
        didSet {
            spinner.stopAnimating()
            self.collectionView?.isHidden = false
            self.collectionView?.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.collectionView?.alpha = 1
            }
        }
    }
    private var collectionView: UICollectionView?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        return spinner
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubviews(spinner, collectionView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with viewModel: ERLocationDetailViewViewModel) {
        self.viewModel = viewModel
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return self.layout(for: section)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EREpisodeInfoCollectionViewCell.self, forCellWithReuseIdentifier: EREpisodeInfoCollectionViewCell.identfier)
        collectionView.register(ERCharacterCollectionViewCell.self, forCellWithReuseIdentifier: ERCharacterCollectionViewCell.cellIdentifier)
        return collectionView
    }
    
    private func addConstraints() {
        
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
    
    private func layout(for section: Int) -> NSCollectionLayoutSection {
        guard let sections = viewModel?.cellViewModels else {
            return createInfolayout()
        }
        
        switch sections[section] {
        case .information:
            return createInfolayout()
        case .characters:
            return createCharacterlayout()
        }
    }
    
    private func createInfolayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(60)),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createCharacterlayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1))
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(250)),
            subitems: [item, item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        return section

    }
}


extension ERLocationDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = viewModel?.cellViewModels else {
            return 0
        }
        let sectionType = sections[section]
        switch sectionType {
            
        case .information(viewModels: let viewModels):
            return viewModels.count
        case .characters(viewModels: let viewModels):
            return  viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sections = viewModel?.cellViewModels else {
            fatalError("No ViewModel")
        }
        let sectionType = sections[indexPath.section]
        switch sectionType {
            
        case .information(viewModels: let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EREpisodeInfoCollectionViewCell.identfier, for: indexPath
            ) as? EREpisodeInfoCollectionViewCell else { fatalError() }
            cell.configure(with: cellViewModel)
            return cell
        case .characters(viewModels: let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ERCharacterCollectionViewCell.cellIdentifier, for: indexPath
            ) as? ERCharacterCollectionViewCell else { fatalError() }
            cell.configure(with: cellViewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let viewModel = viewModel else {
            return
        }
        
        let sections = viewModel.cellViewModels
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .information:
            return
        case .characters:
            guard let character = viewModel.character(at: indexPath.row) else {
                return
            }
            delegate?.erhLocationDetailView(self, didSelect: character)
        }
    }
    
}

