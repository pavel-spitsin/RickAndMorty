//
//  CoreDataManager.swift
//  RickAndMorty
//
//  Created by Pavel on 13.09.2023.
//

import UIKit
import CoreData

public final class CoreDataManager: NSObject {
    public static let shared = CoreDataManager()
    private override init() {}

    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }

    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    public func createCharacter(_ model: CharacterModel) {
        guard let characterEntityDescription = NSEntityDescription.entity(forEntityName: "CoreDataCharacterModel", in: context) else {
            return
        }
        let characterModel = CoreDataCharacterModel(entity: characterEntityDescription, insertInto: context)
        characterModel.id = Int16(model.id)
        characterModel.name = model.name
        characterModel.status = model.status
        characterModel.species = model.species
        characterModel.type = model.type
        characterModel.gender = model.gender
        characterModel.origin = try? NSKeyedArchiver.archivedData(withRootObject: model.origin, requiringSecureCoding: true)
        characterModel.location =  try? NSKeyedArchiver.archivedData(withRootObject: model.location, requiringSecureCoding: true)
        characterModel.imageURL = model.imageURL
        characterModel.episodesURLs = try? NSKeyedArchiver.archivedData(withRootObject: model.episodesURLs, requiringSecureCoding: true)
        characterModel.url = model.url
        characterModel.created = model.created
        characterModel.image = model.image?.jpegData(compressionQuality: 1.0)
        appDelegate.saveContext()
    }
    
    public func fetchCharacter(with id: Int16) -> CoreDataCharacterModel? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataCharacterModel")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let model = try? context.fetch(fetchRequest) as? [CoreDataCharacterModel]
            return model?.first
        }
    }
}
