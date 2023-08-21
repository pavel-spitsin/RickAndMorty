//
//  MainDetailsCell.swift
//  RickAndMorty
//
//  Created by Pavel on 17.08.2023.
//

import UIKit

class DetailsMainCell: UITableViewCell {

    //MARK: - Properties
    
    static let identifier = String(describing: DetailsMainCell.self)
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = CustomColor.white
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = CustomColor.primary
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
        nameLabel.text = ""
        statusLabel.text = ""
    }

    // MARK: - Layout
    
    func configureComponents() {
        self.selectionStyle = .none
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        setupLayout()
    }

    private func setupLayout() {
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(characterImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            characterImageView.heightAnchor.constraint(equalToConstant: 148),
            characterImageView.widthAnchor.constraint(equalToConstant: 148),
            characterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            statusLabel.heightAnchor.constraint(equalToConstant: 20),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}

//MARK: - DetailsCellProtocol

extension DetailsMainCell: DetailsCellProtocol {
    func fillCharacterDetails(character: CharacterDetailsModel, index: Int) {
        characterImageView.image = character.character.image
        nameLabel.text = character.character.name
        statusLabel.text = character.character.status
    }
}
