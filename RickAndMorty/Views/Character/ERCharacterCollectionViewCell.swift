//
//  ERCharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 25/2/23.
//

import UIKit

final class ERCharacterCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "ERCharacterCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        addSubviews(imageView, nameLabel, statusLabel)
        addConstraints()
        setUpLayer()
    }
    
    private func setUpLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.secondaryLabel.cgColor
        contentView.layer.shadowRadius = 1
        contentView.layer.shadowOffset = CGSize(width: -2, height: 2)
        contentView.layer.shadowOpacity = 0.2
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsopported")
    }
    
    private func addConstraints() {
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            statusLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 7),
            statusLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -7),
            nameLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -7),            
            
            statusLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -3),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
            
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            imageView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            imageView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3),
            
            
        ])
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    public func configure(with viewModel: ERCharacterCollectionViewCellViewModel) {
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.charaterStatusText
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
}
