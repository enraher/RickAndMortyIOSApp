//
//  ERSearchViewController.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 26/2/23.
//

import UIKit

class ERSearchViewController: UIViewController {

    struct Config {
        enum `Type` {
            case character
            case episode
            case location
            
            var title: String {
                switch self {
                case .character:
                    return "Search Characters"
                case .episode:
                    return "Search Episode"
                case .location:
                    return "Search Location"
                }
            }
        }
        let type: `Type`
    }
        
    private let viewModel: ERSearchViewViewModel
    private let searchView: ERSearchView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        view.addSubviews(searchView)
        addConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(didTapExecuteSearch))
        searchView.delegate = self
    }
    
    init(config: Config) {
        viewModel = ERSearchViewViewModel(config: config)
        self.searchView = ERSearchView(frame: .zero, viewModel: self.viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        searchView.showKeyBoard()
    }
    
    @objc
    private func didTapExecuteSearch() {
        
    }
    
    private func addConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            searchView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            searchView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

extension ERSearchViewController: ERSearchViewDelegate {
    func erSearchView(_ seacrhView: ERSearchView, didSelect option: ERSearchInputViewViewModel.DynamicOption) {
        
    }
}
