//
//  DetailsInfoCell.swift
//  RickAndMorty
//
//  Created by Pavel on 18.08.2023.
//

import UIKit

class DetailsInfoCell: UITableViewCell {

    //MARK: - Properties
    
    static let identifier = String(describing: DetailsInfoCell.self)

    private lazy var substrateView: UIView = {
        let substrate = UIView()
        substrate.backgroundColor = CustomColor.blackCard
        substrate.layer.cornerRadius = 16
        return substrate
    }()
    private lazy var speciesLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = CustomColor.grayNormal
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.text = "Species:"
        return label
    }()
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = CustomColor.grayNormal
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.text = "Type:"
        return label
    }()
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = CustomColor.grayNormal
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.text = "Gender:"
        return label
    }()
    private lazy var speciesValueLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = CustomColor.white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private lazy var typeValueLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = CustomColor.white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private lazy var genderValueLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = CustomColor.white
        label.font = .systemFont(ofSize: 16, weight: .medium)
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
        speciesValueLabel.text = ""
        typeValueLabel.text = ""
        genderValueLabel.text = ""
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
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesValueLabel.translatesAutoresizingMaskIntoConstraints = false
        typeValueLabel.translatesAutoresizingMaskIntoConstraints = false
        genderValueLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(substrateView)
        substrateView.addSubview(speciesLabel)
        substrateView.addSubview(typeLabel)
        substrateView.addSubview(genderLabel)
        substrateView.addSubview(speciesValueLabel)
        substrateView.addSubview(typeValueLabel)
        substrateView.addSubview(genderValueLabel)

        NSLayoutConstraint.activate([
            substrateView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            substrateView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -8),
            substrateView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            substrateView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            speciesLabel.topAnchor.constraint(equalTo: substrateView.topAnchor, constant: 16),
            speciesLabel.leadingAnchor.constraint(equalTo: substrateView.leadingAnchor, constant: 16),
            speciesLabel.trailingAnchor.constraint(equalTo: substrateView.centerXAnchor),
            speciesLabel.heightAnchor.constraint(equalToConstant: 20),
            
            typeLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 16),
            typeLabel.leadingAnchor.constraint(equalTo: speciesLabel.leadingAnchor),
            typeLabel.trailingAnchor.constraint(equalTo: speciesLabel.trailingAnchor),
            typeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            genderLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 16),
            genderLabel.leadingAnchor.constraint(equalTo: speciesLabel.leadingAnchor),
            genderLabel.trailingAnchor.constraint(equalTo: speciesLabel.trailingAnchor),
            genderLabel.heightAnchor.constraint(equalToConstant: 20),
            genderLabel.bottomAnchor.constraint(equalTo: substrateView.bottomAnchor, constant: -16),
            
            
            speciesValueLabel.topAnchor.constraint(equalTo: speciesLabel.topAnchor),
            speciesValueLabel.leadingAnchor.constraint(equalTo: substrateView.centerXAnchor),
            speciesValueLabel.trailingAnchor.constraint(equalTo: substrateView.trailingAnchor, constant: -16),
            speciesValueLabel.heightAnchor.constraint(equalToConstant: 20),
            
            typeValueLabel.topAnchor.constraint(equalTo: typeLabel.topAnchor),
            typeValueLabel.leadingAnchor.constraint(equalTo: speciesValueLabel.leadingAnchor),
            typeValueLabel.trailingAnchor.constraint(equalTo: speciesValueLabel.trailingAnchor),
            typeValueLabel.heightAnchor.constraint(equalToConstant: 20),
            
            genderValueLabel.topAnchor.constraint(equalTo: genderLabel.topAnchor),
            genderValueLabel.leadingAnchor.constraint(equalTo: speciesValueLabel.leadingAnchor),
            genderValueLabel.trailingAnchor.constraint(equalTo: speciesValueLabel.trailingAnchor),
            genderValueLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}

//MARK: - DetailsCellProtocol

extension DetailsInfoCell: DetailsCellProtocol {
    func fillCharacterDetails(character: CharacterDetailsModel, index: Int) {
        speciesValueLabel.text = character.character.species
        typeValueLabel.text = character.character.type
        genderValueLabel.text = character.character.gender
    }
}
