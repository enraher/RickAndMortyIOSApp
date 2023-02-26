//
//  ERHCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 25/2/23.
//

import UIKit

class ERHCharacterDetailViewController: UIViewController {

    private let viewModel: ERHCharacterDetailViewViewModel
    
    private let detailView: ERHCharacterDetailView
    
    init(viewModel: ERHCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = ERHCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare))
        view.addSubview(detailView)
        addConstraint()
        
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
    }
    
   
    
    @objc
    private func didTapShare() {
        
    }
      
    private func addConstraint() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension ERHCharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .information(let viewModels):
            return viewModels.count
        case .episodes(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.sections[indexPath.section]
        switch section {
        case .photo(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ERHCharacterPhotoCollectionViewCell.cellIdentifier,
                for: indexPath) as? ERHCharacterPhotoCollectionViewCell else {
                fatalError("missing cell")
            }
            cell.configure(with: viewModel)
            return cell
        case .information(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ERHCharacterInfoCollectionViewCell.cellIdentifier,
                for: indexPath) as? ERHCharacterInfoCollectionViewCell else {
                fatalError("missing cell")
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .episodes(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ERHCharacterEpisodeCollectionViewCell.cellIdentifier,
                for: indexPath) as? ERHCharacterEpisodeCollectionViewCell else {
                fatalError("missing cell")
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }

}
