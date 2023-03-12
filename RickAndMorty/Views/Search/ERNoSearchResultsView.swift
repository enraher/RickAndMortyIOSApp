//
//  ERNoSearchResultsView.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 12/3/23.
//

import UIKit

final class ERNoSearchResultsView: UIView {
    
    private let viewModel = ERNoSearchResultsViewViewModel()
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemBlue
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(iconView, label)
        addConstraints()
        configure()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            iconView.heightAnchor.constraint(equalToConstant: 80),
            iconView.widthAnchor.constraint(equalToConstant: 80),
            iconView.topAnchor.constraint(equalTo: topAnchor),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        label.text = viewModel.title
        iconView.image = viewModel.image
    }
}
