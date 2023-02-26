//
//  ERHCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 25/2/23.
//

import UIKit

final class ERHCharacterInfoCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "ERHCharacterInfoCollectionViewCell"
    
    private let containerView: UIView = {
           let view = UIView()
           view.backgroundColor = .systemGray4
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
       
       private let titleContainerView: UIView = {
           let view = UIView()
           view.backgroundColor = .systemGray6
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
       
       private let titleLabel: UILabel = {
           let label = UILabel()
           label.textColor = .black
           label.font = .systemFont(ofSize: 18, weight: .semibold)
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
       
       private let valueLabel: UILabel = {
           let label = UILabel()
           label.textColor = .label
           label.numberOfLines = 0
           label.font = .systemFont(ofSize: 18, weight: .regular)
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()

       private let iconImageView: UIImageView = {
           let icon = UIImageView()
           icon.image = UIImage().withRenderingMode(.alwaysTemplate)
           icon.tintColor = .black
           icon.translatesAutoresizingMaskIntoConstraints = false
           icon.contentMode = .scaleAspectFit
           return icon
       }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 4
        contentView.layer.masksToBounds = true
        titleLabel.textAlignment = .center
        valueLabel.textAlignment = .center
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        
        titleContainerView.addSubview(titleLabel)
        containerView.addSubviews(valueLabel, iconImageView)
        contentView.addSubviews(titleContainerView, containerView)
        
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            containerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            containerView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.66),
            
            titleContainerView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            titleContainerView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.33),
            
            titleLabel.leftAnchor.constraint(equalTo: titleContainerView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: titleContainerView.rightAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            iconImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -12),
            iconImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            valueLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            valueLabel.rightAnchor.constraint(equalTo: iconImageView.leftAnchor),
            valueLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
           
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
        iconImageView.image = nil
        iconImageView.tintColor = .label
        titleLabel.textColor = .label
        
    }
    
    public func configure(with viewModel: ERHCharacterInfoCollectionViewCellViewModel){
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayValue
        iconImageView.image = viewModel.iconImage
        iconImageView.tintColor = viewModel.tintColor
        titleLabel.textColor = viewModel.tintColor
    }
}
