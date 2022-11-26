//
//  PokemonModel.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 24.11.22.
//

import Foundation

struct Pokemon: Codable {
    var name: String
    var image: String?
    var type: String?
    var weight: Int?
    var height: Int?
}
