//
//  ERLocationView.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 9/3/23.
//

import UIKit

protocol ERLocationViewDelegate: AnyObject{
    func erLocationView(_ locationView: ERLocationView, didSelect location: ERLocation)
}

class ERLocationView: UIView {

    public weak var delegate: ERLocationViewDelegate?
        
    private var viewModel: ERLocationViewModel? {
        didSet {
            spinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 1
            }
        }
    }
        
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.alpha = 0
        table.isHidden = true
        table.register(ERLocationTableViewCell.self, forCellReuseIdentifier: ERLocationTableViewCell.identfier)
        return table
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(tableView, spinner)
        spinner.startAnimating()
        addConstraints()
        viewModel = ERLocationViewModel()
        viewModel?.delegate = self
        viewModel?.fetchLocations()
        configureTable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTable(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.heightAnchor.constraint(equalToConstant: 30),
            spinner.widthAnchor.constraint(equalToConstant: 30),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configure(with viewModel: ERLocationViewModel?) {
        self.viewModel = viewModel
    }
}

extension ERLocationView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModels = viewModel?.cellViewModels else {
            fatalError()
        }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ERLocationTableViewCell.identfier, for: indexPath
        ) as? ERLocationTableViewCell else {
            fatalError()
        }
        let cellViewModel = cellViewModels[indexPath.row]
        cell.configure(with: cellViewModel)
        return cell
    }
}

extension ERLocationView: ERLocationViewModelDelegate {
    func didFecthInitialLocation() {
        configure(with: viewModel)
    }
    
    func didLoadMoreLocations(with newIndexPath: [IndexPath]) {
        tableView.performBatchUpdates {
            self.tableView.insertRows(at: newIndexPath, with: .automatic)
        }
    }
}

extension ERLocationView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let locationModel = viewModel?.location(at: indexPath.row) else {
            return
        }
        delegate?.erLocationView(self, didSelect: locationModel)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let url = viewModel?.getNextUrl() else {
            return
        }
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalScrollViewFixedHeight = scrollView.frame.size.height
        
        if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
            viewModel?.fetchAdditionalLocations(url: url)
        }
    }
}
