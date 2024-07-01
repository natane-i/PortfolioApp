//
//  TagCollectionViewCell.swift
//  PortfolioApp
//
//  Created by spark-01 on 2024/06/28.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with imageURL: String) {
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
                // 画像のサイズをセルのサイズに合わせて設定する
                self.imageView.frame = self.bounds
                self.imageView.contentMode = .scaleAspectFill
                self.imageView.image = image
            }
        }.resume()
    }

}
