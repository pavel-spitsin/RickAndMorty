//
//  DetailsEpisodeCell.swift
//  RickAndMorty
//
//  Created by Pavel on 17.08.2023.
//

import UIKit

class DetailsEpisodeCell: UITableViewCell {

    //MARK: - Properties
    
    static let identifier = String(describing: DetailsEpisodeCell.self)

    private lazy var substrateView: UIView = {
        let substrate = UIView()
        substrate.backgroundColor = CustomColor.blackCard
        substrate.layer.cornerRadius = 16
        return substrate
    }()
    private lazy var episodeNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = CustomColor.white
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private lazy var episodeSeasonLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = CustomColor.primary
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private lazy var airDateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = CustomColor.textSecondary
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .right
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
        episodeNameLabel.text = ""
        episodeSeasonLabel.text = ""
        airDateLabel.text = ""
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
        episodeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        episodeSeasonLabel.translatesAutoresizingMaskIntoConstraints = false
        airDateLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(substrateView)
        substrateView.addSubview(episodeNameLabel)
        substrateView.addSubview(episodeSeasonLabel)
        substrateView.addSubview(airDateLabel)

        NSLayoutConstraint.activate([
            substrateView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            substrateView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -8),
            substrateView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            substrateView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            episodeNameLabel.topAnchor.constraint(equalTo: substrateView.topAnchor, constant: 16),
            episodeNameLabel.leadingAnchor.constraint(equalTo: substrateView.leadingAnchor, constant: 16), //15.25 in Figma
            episodeNameLabel.trailingAnchor.constraint(equalTo: substrateView.trailingAnchor, constant: -16), //15.25 in Figma
            episodeNameLabel.heightAnchor.constraint(equalToConstant: 22),

            episodeSeasonLabel.topAnchor.constraint(equalTo: episodeNameLabel.bottomAnchor, constant: 16),
            episodeSeasonLabel.leadingAnchor.constraint(equalTo: episodeNameLabel.leadingAnchor),
            episodeSeasonLabel.trailingAnchor.constraint(equalTo: substrateView.centerXAnchor),
            episodeSeasonLabel.heightAnchor.constraint(equalToConstant: 18),
            episodeSeasonLabel.bottomAnchor.constraint(equalTo: substrateView.bottomAnchor, constant: -14),

            airDateLabel.leadingAnchor.constraint(equalTo: substrateView.centerXAnchor),
            airDateLabel.heightAnchor.constraint(equalToConstant: 16),
            airDateLabel.trailingAnchor.constraint(equalTo: substrateView.trailingAnchor, constant: -16), //15.68 in Figma
            airDateLabel.centerYAnchor.constraint(equalTo: episodeSeasonLabel.centerYAnchor),
        ])
    }
}

//MARK: - DetailsCellProtocol

extension DetailsEpisodeCell: DetailsCellProtocol {
    func fillCharacterDetails(character: CharacterDetailsModel, index: Int) {
        episodeNameLabel.text = character.episodes[index].name
        episodeSeasonLabel.text = StringFormatter.episodeSeasonFormat(string: character.episodes[index].episode)
        airDateLabel.text = character.episodes[index].air_date
    }
}
