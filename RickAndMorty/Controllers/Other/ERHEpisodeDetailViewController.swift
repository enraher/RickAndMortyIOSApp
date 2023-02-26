//
//  ERHEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 26/2/23.
//

import UIKit

final class ERHEpisodeDetailViewController: UIViewController {
    
//    private let viewModel: EpisodeDetailViewViewModel
//    private let episodeDetailView = EpisodeDetailView()
    
    init(url: URL?) {
//        self.viewModel = EpisodeDetailViewViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemBackground
//        setup()
    }
    
}
