//
//  ERLoactionDetailViewController.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 10/3/23.
//

import UIKit




final class ERLocationDetailViewController: UIViewController {
    
    private let viewModel: ERLocationDetailViewViewModel
    private let locationDetailView = ERLocationDetailView()

    init(location: ERLocation) {
        let url = URL(string: location.url)
        self.viewModel = ERLocationDetailViewViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Location"
        view.backgroundColor = .systemBackground
        view.addSubview(locationDetailView)
        locationDetailView.delegate = self
        addConstraints()
        viewModel.delegate = self
        viewModel.fetchLocationData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare))
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            locationDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationDetailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            locationDetailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            locationDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    private func didTapShare() {
        
    }
    
}

extension ERLocationDetailViewController: ERLocationDetailViewViewModelDelegate, ERLocationDetailViewDelegate {
    func erhLocationDetailView(_ detailView: ERLocationDetailView, didSelect character: ERCharacter) {
        let vc = ERCharacterDetailViewController(viewModel: .init(character: character))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didFetchLocationDetails() {
        locationDetailView.configure(with: viewModel)
    }
}
