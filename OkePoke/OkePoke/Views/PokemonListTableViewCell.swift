//
//  PokemonListTableViewCell.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 25.11.22.
//

import UIKit

class PokemonListTableViewCell: UITableViewCell {
    static let identifier = "PokemonListCell"
    
    var viewModel: PokemonListTableViewCellViewModel! {
        didSet {
            pokemonImageView.loadImageFromURL(viewModel.pokemonImage)
            pokemonName.text = viewModel.pokemonName.capitalized
            self.accessoryType = .disclosureIndicator
        }
    }
    
    private let pokemonImageView = CustomImageView()
    private let pokemonName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(pokemonImageView)
        addSubview(pokemonImageView.activityView)
        addSubview(pokemonName)
        configureLabel()
        configureImageView()
        setLabelConstraints()
        setImageConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImageView() {
        pokemonImageView.contentMode = .scaleAspectFit
        pokemonImageView.clipsToBounds = true
    }
    
    func configureLabel() {
        pokemonName.numberOfLines = 0
        pokemonName.adjustsFontSizeToFitWidth = true
        pokemonName.font = UIFont.boldSystemFont(ofSize: 18)
        pokemonName.textColor = .black
    }
    
    func setImageConstraints() {
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        pokemonImageView.activityView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokemonImageView.topAnchor.constraint(equalTo: topAnchor),
            pokemonImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            pokemonImageView.activityView.centerXAnchor.constraint(equalTo: pokemonImageView.centerXAnchor),
            pokemonImageView.activityView.centerYAnchor.constraint(equalTo: pokemonImageView.centerYAnchor)
        ])
    }
    
    func setLabelConstraints() {
        pokemonName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokemonName.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 20),
            pokemonName.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}


