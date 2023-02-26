//
//  ERCharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 25/2/23.
//

import UIKit

class ERCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "ERCharacterEpisodeCollectionViewCell"
    
    private let seasonLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.font = .systemFont(ofSize: 20, weight: .semibold)
           return label
       }()
       
       private let nameLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.font = .systemFont(ofSize: 22, weight: .regular)
           label.adjustsFontSizeToFitWidth = true
           label.minimumScaleFactor = 0.5
           return label
       }()
       
       private let airDateLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.font = .systemFont(ofSize: 18, weight: .light)
           return label
       }()
       
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 4
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray2.cgColor
        contentView.addSubviews(seasonLabel, nameLabel, airDateLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsopported")
    }
    
    private func addConstraints() {
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            seasonLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            seasonLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 10),
            seasonLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -10),
            seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            airDateLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 10),
            airDateLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -10),
            airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
        nameLabel.text = nil
        airDateLabel.text = nil
    }
    
    public func configure(with viewModel: ERCharacterEpisodeCollectionViewCellViewModel){
        viewModel.registerForData { [weak self] data in
            self?.nameLabel.text = data.name
            self?.seasonLabel.text = "Episode " + data.episode
            self?.airDateLabel.text = "Air on" + data.air_date
        }
        viewModel.fetchEpisode()
    }
}
