//
//  PokemonDetailService.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 27.11.22.
//

import Foundation

struct PokemonDetailService {
    
    private let detailURL = "https://pokeapi.co/api/v2/pokemon/"
    
    func loadPokemonDetails(with id: Int, completion: @escaping (PokemonInfo) -> ()) {
        let URLstring = String(detailURL + "\(id)" + "/")
        guard let url = URL(string: URLstring) else { return }
        NetworkManager.shared.fetchData(with: url, ofType: PokemonInfo.self) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print("You have an error:\(error) while decoding Detail Info!")
            }
        }
    }
    
}
