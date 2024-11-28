//
//  UIImageViewExtensions.swift
//  challenge
//
//  Created by Wagner Sales
//

import UIKit

extension UIImageView {
    func loadFromUrl(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, let downloadedImage = UIImage(data: data), error == nil else {
                return
            }

            DispatchQueue.main.async {
                self?.image = downloadedImage
            }
        }

        task.resume()
    }
}
