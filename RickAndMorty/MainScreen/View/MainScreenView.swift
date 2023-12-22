//
//  MainScreenView.swift
//  RickAndMorty
//
//  Created by Pavel on 17.08.2023.
//

import UIKit
import Combine

extension Notification.Name {
    static let ErrorNotification = NSNotification.Name("ErrorNotification")
}

class MainScreenView: BaseViewController {
    
    //MARK: - Properties
    
    weak var coordinator: MainScreenCoordinator?
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
    private lazy var searchBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: .init(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(showSearchBar))
        item.tintColor = CustomColor.grayNormal
        return item
    }()
    private lazy var searchBarView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .clear
        searchBar.searchTextField.backgroundColor = CustomColor.blackCard
        searchBar.searchTextField.tintColor = CustomColor.grayNormal
        searchBar.searchTextField.textColor = CustomColor.grayNormal
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.setImage(UIImage(systemName: "xmark.circle.fill"), for: .clear, state: .normal)
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        return searchBar
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
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorAlert(with:)), name: .ErrorNotification, object: nil)
        configureComponents()
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
    
    private func configureComponents() {
        navigationItem.rightBarButtonItem = searchBarButtonItem
        setupLayout()
    }

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
        viewModel.$infoModel
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.collectionView.reloadData()
            }
            .store(in: &cancelBag)
        
        
        viewModel.$notyfier
            .receive(on: DispatchQueue.main)
            .sink { _ in
                guard self.searchBarView.text != nil else { return }
                self.collectionView.reloadData()
            }
            .store(in: &cancelBag)

        viewModel.$errorCode
            .receive(on: DispatchQueue.main)
            .sink {
                guard let errorCode = $0 else { return }
                self.showErrorAlert(with: errorCode)
            }
            .store(in: &cancelBag)
    }
    
    // MARK: - Actions
    
    @objc private func showSearchBar() {
        UIView.animate(withDuration: 0.3) {
            self.navigationItem.titleView = self.searchBarView
        } completion: { _ in
            self.searchBarView.becomeFirstResponder()
        }
    }
    
    @objc private func showErrorAlert(with errorCode: Int) {
        let alert = UIAlertController(title: "Error", message: "Error code: \(errorCode)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(cancelAction)
        
        UIView.animate(withDuration: 0.3) {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK: - UICollectionViewDataSource

extension MainScreenView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchBarView.text == "" {
            return viewModel.infoModel?.count ?? 826 //826 expected
        } else {
            return viewModel.charactersToShow.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenCollectionCell.identifier,
                                                            for: indexPath) as? MainScreenCollectionCell else { return UICollectionViewCell() }
        
        if searchBarView.text == "" {
            cell.cellViewModel.updateID(id: indexPath.row + 1)
        } else {
            cell.cellViewModel.model = viewModel.charactersToShow[indexPath.row]
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension MainScreenView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MainScreenCollectionCell
        guard let characterModel = cell.cellViewModel.model else { return }
        coordinator?.runDetailsScreen(with: characterModel)
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

//MARK: - UISearchBarDelegate

extension MainScreenView: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3) {
            self.searchBarView.searchTextField.text = ""
            self.navigationItem.titleView = nil
        } completion: { _ in
            self.searchBarView.resignFirstResponder()
        }
        viewModel.updateFilterWord(with: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.updateFilterWord(with: searchBar.text)
        searchBarView.resignFirstResponder()
    }
}
