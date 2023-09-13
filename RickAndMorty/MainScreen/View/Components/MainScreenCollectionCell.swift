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
    private lazy var characterImageViewGradientLoader: GradientLoader  = {
        GradientLoader(superview: characterImageView)
    }()
    private lazy var characterNameLabelGradientLoader: GradientLoader  = {
        GradientLoader(superview: characterNameLabel)
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
        characterImageViewGradientLoader.startGradientAnimation(firstColor: CustomColor.grayNormal?.cgColor,
                                                                secondColor: CustomColor.white?.cgColor)
        
        characterNameLabelGradientLoader.startGradientAnimation(firstColor: CustomColor.grayNormal?.cgColor,
                                                                secondColor: CustomColor.white?.cgColor)
    }

    // MARK: - Layout
    
    private func configureComponents() {
        backgroundColor = .clear
        setupLayout()
    }
    
    private func setupLayout() {
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(characterImageView)
        contentView.addSubview(characterNameLabel)

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
        ])
    }
    
    // MARK: - Actions
    
    func fillInfoForCharacter(_ character: CharacterModel) {
        characterNameLabel.text = character.name
        characterImageView.image = character.image
        characterNameLabelGradientLoader.stopGradientAnimation()
        guard characterImageView.image != nil else { return }
        characterImageViewGradientLoader.stopGradientAnimation()
        isUserInteractionEnabled = true
    }
}
