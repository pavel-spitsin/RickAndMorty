//
//  MainScreenView.swift
//  RickAndMorty
//
//  Created by Pavel on 17.08.2023.
//

import UIKit
import Combine

class MainScreenView: BaseViewController {
    
    //MARK: - Properties
    
    private var viewModel: MainScreenViewModel
    private var cancelBag = Set<AnyCancellable>()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MainScreenCollectionCell.self, forCellWithReuseIdentifier: "MainScreenCollectionCell")
        collectionView.isUserInteractionEnabled = true
        collectionView.indicatorStyle = .white
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: MainCollectionViewFlowLayoutСonstants.scrollIndicatorInsetRight)
        return collectionView
    }()
    
    //MARK: - Init
    
    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Characters"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }
    
    // MARK: - Layout

    private func setupLayout() {
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
    }
    
    //MARK: - Bindings
    
    private func setupBindings() {
        viewModel.$notyfier
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.collectionView.reloadData()
            }
            .store(in: &cancelBag)
    }
}

//MARK: - UICollectionViewDataSource

extension MainScreenView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.infoModel?.count ?? 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenCollectionCell.identifier,
                                                            for: indexPath) as? MainScreenCollectionCell else { return UICollectionViewCell() }
        if (0..<viewModel.charactersArray.count).contains(indexPath.row) {
            cell.fillInfoForCharacter(viewModel.charactersArray[indexPath.row])
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension MainScreenView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailsScreenView(viewModel: DetailsScreenViewModel(character: viewModel.charactersArray[indexPath.row])), animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MainScreenView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,
                            left: MainCollectionViewFlowLayoutСonstants.leftInset,
                            bottom: 0,
                            right: MainCollectionViewFlowLayoutСonstants.rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insetsSum = MainCollectionViewFlowLayoutСonstants.leftInset + MainCollectionViewFlowLayoutСonstants.rightInset + MainCollectionViewFlowLayoutСonstants.minimumInteritemSpacing
        let itemWidth = collectionView.frame.width / 2 - insetsSum/2
        return CGSize(width: itemWidth, height: 202)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return MainCollectionViewFlowLayoutСonstants.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return MainCollectionViewFlowLayoutСonstants.minimumLineSpacing
    }
}
