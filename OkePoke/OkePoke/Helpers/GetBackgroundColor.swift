//
//  GetBackgroundColor.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 29.11.22.
//

import UIKit


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
        return .cyan
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
    case "dark":
        return .darkGray
    case "dragon":
        return .red
    default:
        return .systemTeal
    }
}
