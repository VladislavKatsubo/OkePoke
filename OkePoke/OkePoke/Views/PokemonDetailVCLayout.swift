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
    
    var contentView: UIView = {
        let contentView = UIView()
        contentView.layer.borderWidth = 1
        return contentView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
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
        return label
    }()
    var secondTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .black
        return label
    }()
    
    var weightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .black
        return label
    }()
    
    var heightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .black
        return label
    }()
    
    
    var viewModel: PokemonDetailViewModel! {
        didSet {
            pokemonImageView.loadImageFromURL(viewModel.imageURL)
            nameLabel.text = viewModel.name.capitalized
            if let firstType = viewModel.types[0] {
                firstTypeLabel.text = firstType
                firstTypeLabel.backgroundColor = getBackgroundColor(type: firstType)
            }
            if let secondType = viewModel.types[1] {
                secondTypeLabel.text = secondType
                secondTypeLabel.backgroundColor = getBackgroundColor(type: secondType)
            }
            weightLabel.text = String(viewModel.weight)
            heightLabel.text = String(viewModel.height)
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
        backgroundColor = .white
        
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
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
        
        
        let weightHeightStack = UIStackView(arrangedSubviews: [weightLabel, heightLabel])
        weightHeightStack.axis = .horizontal
        weightHeightStack.distribution = .fillEqually
        weightHeightStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weightHeightStack)
        
        let typesStack = UIStackView(arrangedSubviews: [firstTypeLabel, secondTypeLabel])
        typesStack.axis = .horizontal
        typesStack.distribution = .fillEqually
        typesStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(typesStack)
        
        let allContentStack = UIStackView(arrangedSubviews: [nameLabel, typesStack, weightHeightStack])
        allContentStack.axis = .vertical
        allContentStack.distribution = .fillEqually
        allContentStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(allContentStack)
        
        contentView.addSubview(allContentStack)
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            contentView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            pokemonImageView.bottomAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pokemonImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75)
        ])
    }
    
    func getBackgroundColor(type: String) -> UIColor {
        switch type {
        case "grass":
            return .systemGreen
        case "poison":
            return .systemCyan
        case "bug":
            return .orange
        case "fire":
            return .systemYellow
        case "flying":
            return .systemBlue
        case "water":
            return .systemTeal
        default:
            return .lightGray
        }
    }
    
}
