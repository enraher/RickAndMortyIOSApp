//
//  EREpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 26/2/23.
//

import UIKit

final class EREpisodeDetailViewController: UIViewController {
    
    private let viewModel: EREpisodeDetailViewViewModel
    private let episodeDetailView = EREpisodeDetailView()
    
    init(url: URL?) {
        self.viewModel = EREpisodeDetailViewViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemBackground
        view.addSubview(episodeDetailView)
        episodeDetailView.delegate = self
        addConstraints()
        viewModel.delegate = self
        viewModel.fetchEpisodeData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare))
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            episodeDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeDetailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeDetailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            episodeDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    private func didTapShare() {
        let vc = ERSearchViewController(config: .init(type: .episode))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension EREpisodeDetailViewController: EREpisodeDetailViewViewModelDelegate, EREpisodeDetailViewDelegate {
    func erhEpisodeDetailView(_ detailView: EREpisodeDetailView, didSelect character: ERCharacter) {
        let vc = ERCharacterDetailViewController(viewModel: .init(character: character))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didFetchEpisodeDetails() {
        episodeDetailView.configure(with: viewModel)
    }
}
