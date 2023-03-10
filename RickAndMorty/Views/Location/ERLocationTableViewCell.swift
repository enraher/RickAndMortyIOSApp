//
//  ERLocationTableViewCell.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 10/3/23.
//

import UIKit

class ERLocationTableViewCell: UITableViewCell {
    
    static let identfier = "ERLocationTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    private let dimensionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(nameLabel, typeLabel, dimensionLabel)
        addConstraints()
        self.accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("EREpisodeInfoCollectionViewCell")
    }
    
    
    
    private func addConstraints() {
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -10),
            
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            typeLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 10),
            typeLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -10),
            
            dimensionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 6),
            dimensionLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 10),
            dimensionLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -10),
            dimensionLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
            
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        typeLabel.text = nil
        dimensionLabel.text = nil
    }
    
    func configure(with viewmodel: ERLocationTableViewCellViewModel) {
        nameLabel.text = viewmodel.name
        typeLabel.text = viewmodel.type
        dimensionLabel.text = viewmodel.dimension
    }
    
}

