//
//  ImageCacheService.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 26.11.22.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    let activityView = UIActivityIndicatorView(style: .large)
    var imageUrlString: String?
    
    func loadImageFromURL(_ urlString: String) {
        imageUrlString = urlString
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        activityView.frame = frame
        activityView.center = center
        addSubview(activityView)
        activityView.startAnimating()
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            image = imageFromCache
            activityView.stopAnimating()
            activityView.removeFromSuperview()
            return
        }
        
        NetworkManager.shared.loadImage(url: url) { [weak self] result in
            DispatchQueue.main.async {
                self?.activityView.stopAnimating()
                self?.activityView.removeFromSuperview()
            }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: data) {
                        if self?.imageUrlString == urlString {
                            self?.image = imageToCache
                            imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
