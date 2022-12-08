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
        viewModel.loadPokemonDetails()
        viewModel.downloadedPokemon = { [unowned self] in
            guard let viewModel = viewModel as? PokemonDetailViewModel else { return }
            layout.pokemonImageView.loadImageFromURL(viewModel.imageURL)
            layout.nameLabel.text = layout.setNameLabelText(with: viewModel)
            layout.weightLabel.attributedText = layout.setWeightLabelText(with: viewModel)
            layout.heightLabel.attributedText = layout.setHeightLabelText(with: viewModel)
            layout.setTypeLabels(with: viewModel)
            layout.layer.insertSublayer(layout.getBackgroundGradient(for: viewModel), at: 0)
            layout.infoContainer.applyShadow(cornerRadius: 8)
            layout.addBlur()
        }
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func loadView() {
        super.loadView()
        view = layout
    }
}
