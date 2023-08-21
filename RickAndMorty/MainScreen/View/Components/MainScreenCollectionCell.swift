//
//  MainScreenCollectionCell.swift
//  RickAndMorty
//
//  Created by Pavel on 17.08.2023.
//

import UIKit

class MainScreenCollectionCell: UICollectionViewCell {

    //MARK: - Properties
    
    static let identifier = String(describing: MainScreenCollectionCell.self)

    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = CustomColor.white
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = CustomColor.white
        return indicator
    }()
    
    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        contentView.backgroundColor = CustomColor.blackCard
        contentView.layer.cornerRadius = 16
        configureComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isUserInteractionEnabled = false
        characterNameLabel.text = ""
        characterImageView.image = nil
        activityIndicator.startAnimating()
    }

    // MARK: - Layout
    
    private func configureComponents() {
        backgroundColor = .clear
        setupLayout()
    }
    
    private func setupLayout() {
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(characterImageView)
        contentView.addSubview(characterNameLabel)
        contentView.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor),
            
            characterNameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 16),
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor),
            characterNameLabel.trailingAnchor.constraint(equalTo: characterImageView.trailingAnchor),
            characterNameLabel.heightAnchor.constraint(equalToConstant: 22),
            characterNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            activityIndicator.topAnchor.constraint(equalTo: contentView.topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    // MARK: - Actions
    
    func fillInfoForCharacter(_ character: CharacterModel) {
        characterNameLabel.text = character.name
        characterImageView.image = character.image
        guard characterImageView.image != nil else { return }
        activityIndicator.stopAnimating()
        isUserInteractionEnabled = true
    }
}
