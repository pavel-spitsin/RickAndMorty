//
//  MainScreenCollectionCellViewModel.swift
//  RickAndMorty
//
//  Created by Pavel on 27.09.2023.
//

import Combine
import Foundation

final class MainScreenCollectionCellViewModel: ObservableObject {
    
    //MARK: - Properties
    
    private var cancelBag = Set<AnyCancellable>()
    private let requestService = RequestService()
    @Published private var modelID: Int?
    //Subscribe in cell
    @Published var model: CharacterModel?
    
    //MARK: - Init
    
    init() {
        setupBindings()
    }
    
    //MARK: - Bindings

    private func setupBindings() {
        $modelID
            .receive(on: DispatchQueue.main)
            .sink {
                guard let id = $0 else { return }
                guard let coreDataModel = CoreDataManager.shared.fetchCharacter(with: Int16(id)) else {
                    DispatchQueue.global().async {
                        self.requestService.loadData(urlString: Constants.urlForCharacter(id)) { data in
                            guard let data else { return }
                            var characterModel = CharacterModel(dataResult: data)
                            self.requestService.loadImage(imageURL: characterModel.imageURL) { img in
                                DispatchQueue.main.async {
                                    characterModel.image = img
                                    CoreDataManager.shared.createCharacter(characterModel)
                                    self.model = characterModel
                                }
                            }
                        } errorCompletion: { errorCode in
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: Notification.Name("ErrorNotification"), object: nil)
                            }
                        }
                    }
                    return
                }
                let characterModel = CharacterModel(from: coreDataModel)
                self.model = characterModel
            }
            .store(in: &cancelBag)
    }
    
    //MARK: - Actions
    
    public func stopRequest() {
        requestService.dataTask?.cancel()
    }
    
    public func updateID(id: Int) {
        modelID = id
    }
}
