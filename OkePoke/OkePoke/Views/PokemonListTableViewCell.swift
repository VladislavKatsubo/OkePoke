//
//  PokemonListTableViewCell.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 25.11.22.
//

import UIKit

class PokemonListTableViewCell: UITableViewCell {
    static let identifier = "PokemonListCell"
    private let containerView = UIView()
    
    var viewModel: PokemonListTableViewCellViewModel! {
        didSet {
            pokemonImageView.loadImageFromURL(viewModel.pokemonImage)
            pokemonName.text = viewModel.pokemonName.capitalized
            
            selectionStyle = .none
            accessoryType = .disclosureIndicator
            backgroundColor = .clear
            
            containerView.layer.cornerRadius = 8
            containerView.layer.masksToBounds = true
            containerView.applyShadow(cornerRadius: 6)
        }
    }
    
    private let pokemonImageView = CustomImageView()
    private let pokemonName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(containerView)
        containerView.addSubview(pokemonImageView)
        containerView.addSubview(pokemonImageView.activityView)
        containerView.addSubview(pokemonName)
        containerView.backgroundColor = .white
        
        configureLabel()
        configureImageView()
        setContainerViewConstraints()
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
    
    func setContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
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
    
    func animatePressing() {
        UIView.animate(withDuration: 2, animations: { [weak self] in
            self?.transform =
            CGAffineTransform(scaleX: 0.8, y: 0.8)
        })
        UIView.animate(withDuration: 2, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.containerView.transform =
                CGAffineTransform(scaleX: 0.9, y: 0.9)
            })
            UIView.animate(withDuration: 0.1, animations: { [weak self] in
                self?.containerView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
    }
    
}


