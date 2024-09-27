//
//  ImageDownloader.swift
//  Rick & Roll
//
//  Created by IOSdev on 25/09/2024.
//

import UIKit

extension UIImageView {
    func loadImage(urlString:String){
        
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, res, error in
            guard let self = self else {return}
            if error != nil {return}
            guard let res = res as? HTTPURLResponse, res.statusCode == 200 else {return}
            guard let data = data else {return}
            guard let image = UIImage(data: data) else {return}
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
        
    }
    
    
}
