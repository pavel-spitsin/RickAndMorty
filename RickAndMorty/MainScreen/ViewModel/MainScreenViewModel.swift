//
//  MainScreenViewModel.swift
//  RickAndMorty
//
//  Created by Pavel on 17.08.2023.
//

import Combine
import Foundation
import UIKit

final class MainScreenViewModel: ObservableObject {
    
    //MARK: - Properties
    
    private var cancelBag = Set<AnyCancellable>()
    private(set) var charactersToShow = [CharacterModel]()
    @Published private var charactersArray = [CharacterModel]()
    @Published private var filterWord: String? = nil
    @Published private var infoModel: InfoModel?
    //Subscribe in view
    @Published var notyfier = true
    @Published var errorCode: Int? = nil
    
    //MARK: - Init
    
    init() {
        setupBindings()
        RequestService.getDataByURL(urlString: urlForPage(0), completionBlock: prepareInfoData(data:)) { errorCode in
            self.errorCode = errorCode
        }
    }
    
    //MARK: - Bindings

    private func setupBindings() {
        $infoModel
            .receive(on: DispatchQueue.global(qos: .background))
            .sink { _ in
                let semaphore = DispatchSemaphore(value: 0)
                guard let count = self.infoModel?.pages else { return }
                (1...count).forEach {
                    RequestService.getDataByURL(urlString: self.urlForPage($0)) { data in
                        semaphore.signal()
                        self.prepareCharacterData(data: data)
                    } errorCompletion: { errorCode in
                        self.errorCode = errorCode
                    }
                    semaphore.wait()
                }
            }
            .store(in: &cancelBag)
        
        $charactersArray
            .receive(on: DispatchQueue.global(qos: .background))
            .sink { _ in
                if self.filterWord == nil {
                    self.charactersToShow = self.charactersArray
                } else {
                    self.charactersToShow = self.charactersArray.filter({
                        $0.name.lowercased().contains(self.filterWord!.lowercased())
                    })
                }
            }
            .store(in: &cancelBag)
        
        $filterWord
            .receive(on: DispatchQueue.global(qos: .background))
            .sink { _ in
                if self.filterWord == nil {
                    self.charactersToShow = self.charactersArray
                } else {
                    self.charactersToShow = self.charactersArray.filter({
                        $0.name.lowercased().contains(self.filterWord!.lowercased())
                    })
                }
                
                self.notyfier.toggle()
            }
            .store(in: &cancelBag)
    }
    
    //MARK: - Actions
    
    private func urlForPage(_ number: Int) -> String {
        "https://rickandmortyapi.com/api/character/?page=\(number)"
    }
    
    private func prepareInfoData(data: [String : AnyObject]?) {
        guard let dataInfo = data?["info"] as? [String : AnyObject] else { return }
        infoModel = InfoModel(dataInfo: dataInfo)
    }

    private func prepareCharacterData(data: [String : AnyObject]?) {
        guard let dataResults = data?["results"] as? [[String : AnyObject]] else { return }
        let characterModels = dataResults.map {
            CharacterModel(dataResult: $0)
        }
        self.charactersArray.append(contentsOf: characterModels)

        let charactersArrayCopy = charactersArray
        let group = DispatchGroup()
        for (index, charModel) in charactersArrayCopy.enumerated() {
            group.enter()
            RequestService.getImage(imageURL: charModel.imageURL) { img in
                self.charactersArray[index].image = img
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.notyfier.toggle()
        }
    }
    
    func updateFilterWord(with text: String?) {
        filterWord = text
    }
}
