//
//  DetailsScreenView.swift
//  RickAndMorty
//
//  Created by Pavel on 17.08.2023.
//

import UIKit
import Combine

class DetailsScreenView: BaseViewController {
    
    //MARK: - Properties
    
    private var viewModel: DetailsScreenViewModel
    private var cancelBag = Set<AnyCancellable>()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DetailsMainCell.self, forCellReuseIdentifier: "DetailsMainCell")
        tableView.register(DetailsInfoCell.self, forCellReuseIdentifier: "DetailsInfoCell")
        tableView.register(DetailsEpisodeCell.self, forCellReuseIdentifier: "DetailsEpisodeCell")
        tableView.register(DetailsOriginCell.self, forCellReuseIdentifier: "DetailsOriginCell")
        tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        tableView.isHidden = true
        return tableView
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = CustomColor.white
        return indicator
    }()
    
    //MARK: - Init
    
    init(viewModel: DetailsScreenViewModel) {
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
        tableView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.topAnchor.constraint(equalTo: view.topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    //MARK: - Bindings
    
    private func setupBindings() {
        viewModel.$characterDetailsModel
            .receive(on: DispatchQueue.main)
            .sink { model in
                guard model != nil else { return }
                self.updateViews()
            }
            .store(in: &cancelBag)
    }
    
    //MARK: - Actions
    
    private func updateViews() {
        tableView.reloadData()
        tableView.isHidden = false
        activityIndicator.stopAnimating()
    }
}

//MARK: - Table View Datasource

extension DetailsScreenView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DetailsTableViewSourceManager.init(rawValue: section)?.numberOfRowsInSection(viewModel: viewModel) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        DetailsTableViewSourceManager.init(rawValue: indexPath.section)?.cellForRow(tableView, cellForRowAt: indexPath, viewModel: viewModel) ?? UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        DetailsTableViewSourceManager.allCases.count
    }
}

//MARK: - Table View Delegate

extension DetailsScreenView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        DetailsTableViewSourceManager.init(rawValue: section)?.headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        DetailsTableViewSourceManager.init(rawValue: indexPath.section)?.heightForRow ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
}
