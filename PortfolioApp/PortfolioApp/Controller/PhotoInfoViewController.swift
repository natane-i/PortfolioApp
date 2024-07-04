//
//  PhotoInfoViewController.swift
//  PortfolioApp
//
//  Created by spark-01 on 2024/06/25.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var distributorLabel: UILabel!
    @IBOutlet weak var updateAtLabel: UILabel!
    
    var photoDatas: [PhotoData] = []
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage(at: currentIndex)
        setupGesture()
        
        let slug = photoDatas[currentIndex].alternative_slugs.ja
        let jaSlug = slug.replacingOccurrences(of: photoDatas[currentIndex].id, with: "")
        let slugString = jaSlug.components(separatedBy: CharacterSet(charactersIn: "-")).joined()
        self.title = slugString
    }
    
    private func setupGesture() {
        let tapPhotoGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapPhoto(_:)))
        tapPhotoGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tapPhotoGesture)
        imageView.isUserInteractionEnabled = true
        
        let tapUserNameGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapUserName(_:)))
        userNameLabel.isUserInteractionEnabled = true
        userNameLabel.addGestureRecognizer(tapUserNameGesture)
        
        let tapDistributorGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDistributor(_:)))
        distributorLabel.isUserInteractionEnabled = true
        distributorLabel.addGestureRecognizer(tapDistributorGesture)
    }
    
    @objc func handleTapPhoto(_ gesture: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ToDetail", sender: self)
    }
    
    @objc func handleTapUserName(_ sender: UITapGestureRecognizer) {
        let photoData = photoDatas[currentIndex]
        let userLink = photoData.user.links.html
        
        if let url = URL(string: userLink) {
            let webVC = WebViewController(url: url)
            present(webVC, animated: true, completion: nil)
        }
    }
    
    @objc func handleTapDistributor(_ sender: UITapGestureRecognizer) {
        let unsplashLink = "https://unsplash.com/ja"
        
        if let url = URL(string: unsplashLink) {
            let webVC = WebViewController(url: url)
            present(webVC, animated: true, completion: nil)
        }
    }
    
    func loadImage(at index: Int) {
        let photoData = photoDatas[index]
        let imageURL = photoData.urls.regular
        let userName = photoData.user.name
        let distributor = photoData.user.location
        let updateAt = photoData.updated_at
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        let dateString = formatter.string(from: updateAt)
        
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
                self.userNameLabel.text = userName
                self.distributorLabel.text = distributor
                self.updateAtLabel.text = dateString
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetail" {
            if let photoDetailVC = segue.destination as? PhotoDetailViewController {
                photoDetailVC.photoData = photoDatas[currentIndex].urls.regular
            }
        }
    }
    
}
