//
//  CoreDataCharacterModel.swift
//  RickAndMorty
//
//  Created by Pavel on 13.09.2023.
//

import Foundation
import UIKit
import CoreData

@objc(CoreDataCharacterModel)
public class CoreDataCharacterModel: NSManagedObject {}

extension CoreDataCharacterModel {
    @NSManaged public var id: Int16
    @NSManaged public var name: String
    @NSManaged public var status: String
    @NSManaged public var species: String
    @NSManaged public var type: String
    @NSManaged public var gender: String
    @NSManaged public var origin: Data?
    @NSManaged public var location: Data?
    @NSManaged public var imageURL: String
    @NSManaged public var episodesURLs: Data?
    @NSManaged public var url: String
    @NSManaged public var created: String
    @NSManaged public var image: Data?
}

extension CoreDataCharacterModel: Identifiable {}
