//
//  PokemonDetailViewController.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 27.11.22.
//

import UIKit

final class PokemonDetailViewController: UIViewController {
    
    lazy var layout: PokemonDetailVCLayout = .init()
    var viewModel: PokemonDetailViewModelProtocol
    
    init(viewModel: PokemonDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.pokemonDetailedInfo.bind { [weak self] pokemonInfo in
            guard let pokemonInfo = pokemonInfo, let layout = self?.layout, let viewModel = self?.viewModel else { return }
            layout.pokemonImageView.loadImageFromURL(viewModel.imageURL)
            layout.nameLabel.text = layout.setNameLabelText(withID: pokemonInfo.id, name: pokemonInfo.name)
            layout.weightLabel.attributedText = layout.setWeightLabelText(with: pokemonInfo.weight)
            layout.heightLabel.attributedText = layout.setHeightLabelText(with: pokemonInfo.height)
            layout.setTypeLabels(with: pokemonInfo)
            layout.layer.insertSublayer(layout.getBackgroundGradient(for: pokemonInfo), at: 0)
            layout.infoContainer.applyShadow(cornerRadius: 8)
            layout.addBlur()
        }
        
        viewModel.loadPokemonDetails()
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func loadView() {
        super.loadView()
        view = layout
    }
}
