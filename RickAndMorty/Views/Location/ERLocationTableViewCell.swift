//
//  ERLocationTableViewCell.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 10/3/23.
//

import UIKit

class ERLocationTableViewCell: UITableViewCell {

    static let identfier = "ERLocationTableViewCell"
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
//        contentView.addSubviews(titleLabel, valueLabel)
//
//        layer.cornerRadius = 8
//        layer.masksToBounds = true
//        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("EREpisodeInfoCollectionViewCell")
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
    
    func configure(with viewmodel: ERLocationTableViewCellViewModel) {
//        titleLabel.text = viewmodel.title
//        valueLabel.text = viewmodel.value
    }

}
