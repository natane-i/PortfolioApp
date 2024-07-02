//
//  TagCollectionViewCell.swift
//  PortfolioApp
//
//  Created by spark-01 on 2024/06/28.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func configure(with imageURL: String, userName: String) {
        guard let url = URL(string: imageURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                print(self.imageView.bounds.size)
                self.imageView.image = image
                self.label.text = userName
            }
        }.resume()
    }

}
