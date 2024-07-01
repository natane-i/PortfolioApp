//
//  PhotoInfoViewController.swift
//  PortfolioApp
//
//  Created by spark-01 on 2024/06/25.
//

import UIKit

class PhotoInfoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var imageURLs: [String] = []
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage(at: currentIndex)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(doubleTapGesture)
        imageView.isUserInteractionEnabled = true

    }

    func loadImage(at index: Int) {
        let imageURL = imageURLs[index]
        
        guard let url = URL(string: imageURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("エラー: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }.resume()
    }
    
    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetail" {
            if let photoDetailVC = segue.destination as? PhotoDetailViewController {
                photoDetailVC.imageURLs = self.imageURLs
                photoDetailVC.currentIndex = self.currentIndex
            }
        }
    }

}