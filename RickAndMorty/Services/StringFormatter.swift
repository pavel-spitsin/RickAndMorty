//
//  StringFormatter.swift
//  RickAndMorty
//
//  Created by Pavel on 19.08.2023.
//

import Foundation

struct StringFormatter {
    static func episodeSeasonFormat(string: String) -> String {
        var str = string
        str.removeFirst()
        let array = str.components(separatedBy: "E")
        guard let season = Int(array[0]), let episode = Int(array[1]) else {
            return "Episode: -, Season: -"
        }
        return "Episode: \(episode), Season: \(season)"
    }
}
