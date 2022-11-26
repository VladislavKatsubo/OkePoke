//
//  PokemonCellService.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 26.11.22.
//

import Foundation


struct PokemonCellService {
        
    func loadPokemons(with url: String, completion: @escaping (PokeapiResponse) -> ()) {
        guard let url = URL(string: url) else { return }
        NetworkManager.shared.fetchData(with: url, ofType: PokeapiResponse.self) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
