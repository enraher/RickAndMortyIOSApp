//
//  CharacterPhotoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 25/2/23.
//

import UIKit

final class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterPhotoCollectionViewCell"
    
//    private let containerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .systemGray4
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        addConstraints()
        setUpLayer()
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }

    private func setUpViews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
//        containerView.clipsToBounds = true

        contentView.addSubview(imageView)
//        contentView.addSubview(containerView)
//        containerView.addSubview(imageView)
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setUpLayer() {
//        containerView.layer.cornerRadius = containerView.frame.height / 2
//        imageView.layer.cornerRadius = imageView.frame.height / 2
//        contentView.layer.shadowColor = UIColor.label.cgColor
//        contentView.layer.shadowRadius = 4
//        contentView.layer.shadowOffset = CGSize(width: -8, height: 8)
//        contentView.layer.shadowOpacity = 0.3
    }

    public func configure(with viewModel: RMCharacterPhotoCollectionViewCellViewModel) {
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                    self?.setUpLayer()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
