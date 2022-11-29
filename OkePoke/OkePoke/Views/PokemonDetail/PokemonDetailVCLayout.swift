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
        return label
    }()
    
    var firstTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    var secondTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .black
        return label
    }()
    
    var weightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    var heightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    
    var viewModel: PokemonDetailViewModel! {
        didSet {
            pokemonImageView.loadImageFromURL(viewModel.imageURL)
            nameLabel.text = setNameLabelText(with: viewModel)
            weightLabel.attributedText = setWeightLabelText(with: viewModel)
            heightLabel.attributedText = setHeightLabelText(with: viewModel)
            setTypeLabels(with: viewModel)
            layer.insertSublayer(getBackgroundGradient(for: viewModel), at: 0)
            infoContainer.applyShadow(cornerRadius: 8)
            addBlur()
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
        addSubview(pokemonImageView.activityView)
        pokemonImageView.activityView.translatesAutoresizingMaskIntoConstraints = false
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
        weightHeightStack.axis = .horizontal
        weightHeightStack.setCustomSpacing(30, after: weightLabel)
        weightHeightStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weightHeightStack)
        
        
        let typesStack = UIStackView(arrangedSubviews: [firstTypeLabel, secondTypeLabel])
        typesStack.axis = .horizontal
        typesStack.setCustomSpacing(40, after: firstTypeLabel)
        typesStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(typesStack)
        
        infoContainer.addSubview(nameLabel)
        infoContainer.addSubview(typesStack)
        infoContainer.addSubview(weightHeightStack)
        
        
        NSLayoutConstraint.activate([
            infoContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            infoContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            weightHeightStack.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: -100),
            weightHeightStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            typesStack.bottomAnchor.constraint(equalTo: weightHeightStack.topAnchor, constant: -50),
            typesStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: typesStack.topAnchor, constant: -50),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor),
            pokemonImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pokemonImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 100),
            pokemonImageView.widthAnchor.constraint(equalTo: infoContainer.widthAnchor, multiplier: 0.75),
            pokemonImageView.activityView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pokemonImageView.activityView.centerYAnchor.constraint(equalTo: infoContainer.topAnchor)
        ])
    }
    
    func setTypeLabels(with viewModel: PokemonDetailViewModel) {
        let firstType = viewModel.types[0]
        firstTypeLabel.text = firstType.uppercased()
        firstTypeLabel.textColor = getBackgroundColor(type: firstType)
        if viewModel.types.count > 1 {
            let secondType = viewModel.types[1]
            secondTypeLabel.text = secondType.uppercased()
            secondTypeLabel.textColor = getBackgroundColor(type: secondType)
        } else {
            secondTypeLabel.isHidden = true
        }
    }
    
    func setNameLabelText(with viewModel: PokemonDetailViewModel) -> String {
        return "#" + String(viewModel.pokemonID) + " " + viewModel.name.capitalized
    }
    
    func setWeightLabelText(with viewModel: PokemonDetailViewModel) -> NSAttributedString {
        addSymbolPrefix(with: "dumbbell.fill", for: "\(Double(viewModel.weight)/10) kg")
    }
    
    func setHeightLabelText(with viewModel: PokemonDetailViewModel) -> NSAttributedString {
        addSymbolPrefix(with: "arrow.up.and.down", for: "\(Double(viewModel.height)/10) m")
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
    
    func addBlur() {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        insertSubview(blurEffectView, at: 1)
    }
    
}
