//
//  Components.swift
//  Rick & Roll
//
//  Created by Gracie on 24/09/2024.
//

import UIKit

extension UIImageView {
    func setImageFromURL(url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}

