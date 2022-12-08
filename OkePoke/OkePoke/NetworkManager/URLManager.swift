//
//  URLManager.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 7.12.22.
//

import Foundation

struct URLManager {
    var path: String
}

extension URLManager {
    var infoURL: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pokeapi.co"
        components.path = "/" + path
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        return url
    }
    var imageURL: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "raw.githubusercontent.com"
        components.path = "/" + path + ".png"
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        return url
    }
}

extension URLManager {
    static var pokemonListURL: Self {
        URLManager(path: "api/v2/pokemon/")
    }
    static func pokemonListImageURL(forID id: Int) -> Self {
        URLManager(path: "PokeAPI/sprites/master/sprites/pokemon/\(id)")
    }
    
    static func pokemonDetailInfoURL(withID id: Int) -> Self {
        URLManager(path: "api/v2/pokemon/\(id)")
    }
    
    static func pokemonFullDetailImageURL(forID id: Int) -> Self {
        URLManager(path: "PokeAPI/sprites/master/sprites/pokemon/other/home/\(id)")
    }
}
