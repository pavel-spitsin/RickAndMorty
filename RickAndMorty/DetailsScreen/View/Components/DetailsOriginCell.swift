//
//  DetailsOriginCell.swift
//  RickAndMorty
//
//  Created by Pavel on 18.08.2023.
//

import UIKit

class DetailsOriginCell: UITableViewCell {

    //MARK: - Properties
    
    static let identifier = String(describing: DetailsOriginCell.self)

    private lazy var substrateView: UIView = {
        let substrate = UIView()
        substrate.backgroundColor = CustomColor.blackCard
        substrate.layer.cornerRadius = 16
        return substrate
    }()
    private lazy var imageSubstrateView: UIView = {
        let substrate = UIView()
        substrate.backgroundColor = CustomColor.blackElements
        substrate.layer.cornerRadius = 10
        return substrate
    }()
    private lazy var planetImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Planet"))
        imageView.backgroundColor = .clear
        imageView.tintColor = CustomColor.white
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var originNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = CustomColor.white
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private lazy var originTypeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = CustomColor.primary
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textAlignment = .left
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
        originNameLabel.text = ""
    }

    // MARK: - Layout
    
    func configureComponents() {
        self.selectionStyle = .none
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        setupLayout()
    }
    
    func setupLayout() {
        substrateView.translatesAutoresizingMaskIntoConstraints = false
        imageSubstrateView.translatesAutoresizingMaskIntoConstraints = false
        planetImageView.translatesAutoresizingMaskIntoConstraints = false
        originNameLabel.translatesAutoresizingMaskIntoConstraints = false
        originTypeLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(substrateView)
        substrateView.addSubview(imageSubstrateView)
        imageSubstrateView.addSubview(planetImageView)
        substrateView.addSubview(originNameLabel)
        substrateView.addSubview(originTypeLabel)

        NSLayoutConstraint.activate([
            substrateView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            substrateView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -8),
            substrateView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            substrateView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            imageSubstrateView.heightAnchor.constraint(equalToConstant: 64),
            imageSubstrateView.widthAnchor.constraint(equalToConstant: 64),
            imageSubstrateView.topAnchor.constraint(equalTo: substrateView.topAnchor, constant: 8),
            imageSubstrateView.bottomAnchor.constraint(equalTo: substrateView.bottomAnchor, constant: -8),
            imageSubstrateView.leadingAnchor.constraint(equalTo: substrateView.leadingAnchor, constant: 8),
            
            planetImageView.heightAnchor.constraint(equalToConstant: 20),
            planetImageView.widthAnchor.constraint(equalToConstant: 22),
            planetImageView.centerXAnchor.constraint(equalTo: imageSubstrateView.centerXAnchor),
            planetImageView.centerYAnchor.constraint(equalTo: imageSubstrateView.centerYAnchor),
            
            originNameLabel.topAnchor.constraint(equalTo: substrateView.topAnchor, constant: 16),
            originNameLabel.leadingAnchor.constraint(equalTo: imageSubstrateView.trailingAnchor, constant: 16),
            originNameLabel.trailingAnchor.constraint(equalTo: substrateView.trailingAnchor, constant: -16),
            originNameLabel.heightAnchor.constraint(equalToConstant: 22),
            
            originTypeLabel.topAnchor.constraint(equalTo: originNameLabel.bottomAnchor, constant: 8),
            originTypeLabel.leadingAnchor.constraint(equalTo: originNameLabel.leadingAnchor),
            originTypeLabel.trailingAnchor.constraint(equalTo: originNameLabel.trailingAnchor),
            originTypeLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
}

//MARK: - DetailsCellProtocol

extension DetailsOriginCell: DetailsCellProtocol {
    func fillCharacterDetails(character: CharacterDetailsModel, index: Int) {
        originNameLabel.text = character.location.name
        originTypeLabel.text = character.location.type
    }
}
