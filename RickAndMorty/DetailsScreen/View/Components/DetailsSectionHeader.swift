//
//  DetailsSectionHeader.swift
//  RickAndMorty
//
//  Created by Pavel on 18.08.2023.
//

import UIKit

class DetailsSectionHeader: UIView {
    
    //MARK: - Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = CustomColor.white
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK: - Init
    
    init(title: String) {
        super.init(frame: .zero)
        backgroundColor = .clear
        setupLayout()
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout

    private func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
}
