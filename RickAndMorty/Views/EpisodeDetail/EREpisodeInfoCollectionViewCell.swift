//
//  EREpisodeInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 26/2/23.
//

import UIKit

class EREpisodeInfoCollectionViewCell: UICollectionViewCell {
    static let identfier = "EREpisodeInfoCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
       }()
       
       private let valueLabel: UILabel = {
           let label = UILabel()
           label.font = .systemFont(ofSize: 18, weight: .regular)
           label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
           label.numberOfLines = 0
           return label
       }()
    
    required init?(coder: NSCoder) {
        fatalError("EREpisodeInfoCollectionViewCell")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(titleLabel, valueLabel)
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        addConstraints()
    }
    
    
    private func addConstraints() {
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 4),
            titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -4),
            
            valueLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 4),
            valueLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -10),
            valueLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -4),
            
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.35),
            valueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.65),
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
    }
    
    func configure(with viewmodel: EREpisodeInfoCollectionViewCellViewModel) {
        titleLabel.text = viewmodel.title
        valueLabel.text = viewmodel.value
    }
}
