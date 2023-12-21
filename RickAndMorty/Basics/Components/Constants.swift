//
//  Constants.swift
//  RickAndMorty
//
//  Created by Pavel on 28.09.2023.
//

import Foundation

public struct Constants {
    static public func urlForPage(_ number: Int) -> String {
        "https://rickandmortyapi.com/api/character/?page=\(number)"
    }
    
    static public func urlForCharacter(_ number: Int) -> String {
        "https://rickandmortyapi.com/api/character/\(number)"
    }
}
