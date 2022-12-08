//
//  PokemonListService.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 25.11.22.
//

import Foundation

protocol PokemonListServiceProtocol {
    func loadPokemonData(with url: URL, completion: @escaping (PokeapiResponse) -> ())
    init(networkManager: NetworkManagerProtocol)
}

struct PokemonListService: PokemonListServiceProtocol {
        
    internal let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func loadPokemonData(with url: URL, completion: @escaping (PokeapiResponse) -> ()) {
        networkManager.fetchData(with: url, ofType: PokeapiResponse.self) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
