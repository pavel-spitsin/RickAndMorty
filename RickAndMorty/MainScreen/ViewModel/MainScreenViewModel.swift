//
//  MainScreenViewModel.swift
//  RickAndMorty
//
//  Created by Pavel on 17.08.2023.
//

import Combine
import UIKit

final class MainScreenViewModel: ObservableObject {
    
    //MARK: - Properties
    
    private var cancelBag = Set<AnyCancellable>()
    private(set) var charactersToShow = [CharacterModel]()
    @Published private var charactersDictionary: [Int : CharacterModel] = [:]
    @Published private var filterWord: String?
    //Subscribe in view
    @Published var notyfier = true
    @Published private(set) var infoModel: InfoModel?
    @Published var errorCode: Int? = nil
    
    //MARK: - Init
    
    init() {
        setupBindings()
        RequestService().loadData(urlString: Constants.urlForPage(0), completionBlock: prepareInfoData(data:)) { errorCode in
            self.errorCode = errorCode
        }
    }
    
    //MARK: - Bindings

    private func setupBindings() {
        $infoModel
            .receive(on: DispatchQueue.global(qos: .background))
            .sink {
                guard let count = $0?.count else { return }
                (1...count).forEach { index in
                    RequestService().loadData(urlString: Constants.urlForCharacter(index)) { data in
                        guard let data else { return }
                        var characterModel = CharacterModel(dataResult: data)
                        RequestService().loadImage(imageURL: characterModel.imageURL) { img in
                            characterModel.image = img
                            self.charactersDictionary[characterModel.id] = characterModel
                        }
                    } errorCompletion: { errorCode in
                        self.errorCode = errorCode
                    }
                }
            }
            .store(in: &cancelBag)

        $charactersDictionary
            .receive(on: DispatchQueue.global(qos: .background))
            .sink { _ in
                if self.filterWord == nil {
                    self.charactersToShow = self.charactersDictionary.values.sorted(by: { $0.id < $1.id })
                } else {
                    self.charactersToShow = self.charactersDictionary.values.sorted(by: { $0.id < $1.id }).filter({
                        $0.name.lowercased().contains(self.filterWord?.lowercased() ?? "")
                    })
                    self.notyfier.toggle()
                }
            }
            .store(in: &cancelBag)
        
        $filterWord
            .receive(on: DispatchQueue.global(qos: .background))
            .sink {
                if let filter = $0 {
                    self.charactersToShow = self.charactersDictionary.values.sorted(by: { $0.id < $1.id }).filter({
                        $0.name.lowercased().contains(filter.lowercased())
                    })
                }
                self.notyfier.toggle()
            }
            .store(in: &cancelBag)
    }
    
    //MARK: - Actions
    
    private func prepareInfoData(data: [String : AnyObject]?) {
        guard let dataInfo = data?["info"] as? [String : AnyObject] else { return }
        infoModel = InfoModel(dataInfo: dataInfo)
    }
    
    public func updateFilterWord(with text: String?) {
        filterWord = text
    }
}
