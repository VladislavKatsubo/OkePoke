//
//  PokemonDetailViewController.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 27.11.22.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemonDetailViewModel: PokemonDetailViewModel! {
        didSet {
            pokemonDetailViewModel.loadPokemonDetails()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonDetailViewModel.downloadedPokemon = { [weak self] in
            print(self?.pokemonDetailViewModel.name)
        }
    }
}
