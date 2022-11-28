//
//  PokemonDetailVCLayout.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 27.11.22.
//

import UIKit


class PokemonDetailVCLayout: UIView {
        
    var pokemonImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var infoContainer: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        return contentView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .black
        return label
    }()
    
    var firstTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .black
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 20
        return label
    }()
    var secondTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .black
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 20
        return label
    }()
    
    var weightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .black
        return label
    }()
    
    var heightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .black
        return label
    }()
    
    
    var viewModel: PokemonDetailViewModel! {
        didSet {
            pokemonImageView.loadImageFromURL(viewModel.imageURL)
            nameLabel.text = setNameLabelText(with: viewModel)
            setTypeLabels(with: viewModel)
            weightLabel.text = setWeightLabelText(with: viewModel)
            heightLabel.text = setHeightLabelText(with: viewModel)
            layer.insertSublayer(getBackgroundGradient(for: viewModel), at: 0)
            infoContainer.applyShadow(cornerRadius: 8)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureScreen() {
        addSubview(infoContainer)
        infoContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pokemonImageView)
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(firstTypeLabel)
        firstTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(secondTypeLabel)
        secondTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weightLabel)
        weightLabel.translatesAutoresizingMaskIntoConstraints  = false
        addSubview(heightLabel)
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let weightHeightStack = UIStackView(arrangedSubviews: [
            weightLabel, heightLabel
        ])
        weightHeightStack.translatesAutoresizingMaskIntoConstraints = false
        weightHeightStack.axis = .horizontal
        weightHeightStack.setCustomSpacing(20, after: weightLabel)
        addSubview(weightHeightStack)
        
        
        let typesStack = UIStackView(arrangedSubviews: [
            firstTypeLabel, secondTypeLabel
        ])
        typesStack.axis = .horizontal
        typesStack.setCustomSpacing(20, after: firstTypeLabel)
        typesStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(typesStack)
        
        let allContentStack = UIStackView(arrangedSubviews: [
            nameLabel, typesStack, weightHeightStack
        ])
        allContentStack.axis = .vertical
        allContentStack.distribution = .fillEqually
        allContentStack.spacing = 50
        allContentStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(allContentStack)
        
        infoContainer.addSubview(allContentStack)
        
        NSLayoutConstraint.activate([
            infoContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            infoContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            allContentStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            allContentStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50),
            pokemonImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pokemonImageView.bottomAnchor.constraint(equalTo: allContentStack.topAnchor, constant: 100),
            pokemonImageView.widthAnchor.constraint(equalTo: infoContainer.widthAnchor, multiplier: 0.75)
        ])
    }
    
    func getBackgroundColor(type: String) -> UIColor {
        switch type {
        case "grass":
            return .systemGreen
        case "poison":
            return .magenta
        case "bug":
            return .systemOrange
        case "fire":
            return .systemYellow
        case "flying":
            return .systemCyan
        case "water":
            return .systemBlue
        case "fairy":
            return .systemPink
        case "ground":
            return .systemBrown
        case "rock":
            return .brown
        case "fighting":
            return .systemRed
        case "psychic":
            return .systemIndigo
        case "electric":
            return .cyan
        case "steel":
            return .lightGray
        default:
            return .systemMint
        }
    }
    
    func setTypeLabels(with viewModel: PokemonDetailViewModel) {
        let firstType = viewModel.types[0]
        firstTypeLabel.text = firstType
        firstTypeLabel.backgroundColor = getBackgroundColor(type: firstType)
        if viewModel.types.count > 1 {
            let secondType = viewModel.types[1]
            secondTypeLabel.text = secondType
            secondTypeLabel.backgroundColor = getBackgroundColor(type: secondType)
        } else {
            secondTypeLabel.isHidden = true
        }
    }
    
    func setNameLabelText(with viewModel: PokemonDetailViewModel) -> String {
        return "#" + String(viewModel.pokemonID) + " " + viewModel.name.capitalized
    }
    
    func setWeightLabelText(with viewModel: PokemonDetailViewModel) -> String {
        "\(Double(viewModel.weight)/10) kg"
    }
    
    func setHeightLabelText(with viewModel: PokemonDetailViewModel) -> String {
        "\(Double(viewModel.height)/10) m"
    }
    
    func getBackgroundGradient(for viewModel: PokemonDetailViewModel) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        switch viewModel.types.count {
        case 2:
            gradientLayer.colors = [
                getBackgroundColor(type: viewModel.types[0]).cgColor,
                getBackgroundColor(type: viewModel.types[1]).cgColor
            ]
        default:
            gradientLayer.colors = [
                getBackgroundColor(type: viewModel.types[0]).cgColor,
                UIColor.white.cgColor
            ]
        }
        gradientLayer.frame = self.bounds
        return gradientLayer
    }
    
}
