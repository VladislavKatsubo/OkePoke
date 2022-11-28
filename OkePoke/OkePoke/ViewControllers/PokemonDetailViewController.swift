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
    
    lazy var layout: PokemonDetailVCLayout = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonDetailViewModel.downloadedPokemon = { [weak self] in
            self?.layout.viewModel = self?.pokemonDetailViewModel
        }
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func loadView() {
        super.loadView()
        view = layout
    }
}
