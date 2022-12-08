//
//  PokemonDetailService.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 27.11.22.
//

import Foundation

protocol PokemonDetailServiceProtocol {
    func loadPokemonDetails(for url: URL, with id: Int, completion: @escaping (PokemonInfo) -> ())
    init(networkManager: NetworkManagerProtocol)
}

struct PokemonDetailService: PokemonDetailServiceProtocol {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    
    func loadPokemonDetails(for url: URL, with id: Int, completion: @escaping (PokemonInfo) -> ()) {
        networkManager.fetchData(with: url, ofType: PokemonInfo.self) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print("You have an error:\(error.localizedDescription) while decoding Detail Info!")
            }
        }
    }
    
}
