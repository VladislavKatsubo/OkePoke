//
//  AddSFSymbol.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 29.11.22.
//

import UIKit

    func addSymbolPrefix(with symbol: String, for text: String) -> NSAttributedString {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "\(symbol)", withConfiguration: UIImage.SymbolConfiguration(scale: .large))?.withTintColor(.black)
        let fullString = NSMutableAttributedString(string: "")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        fullString.append(NSAttributedString(string: " \(text)"))
        return fullString
        
    }
