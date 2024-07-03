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
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(doubleTapGesture)
        imageView.isUserInteractionEnabled = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        userNameLabel.isUserInteractionEnabled = true
        userNameLabel.addGestureRecognizer(tapGesture)
        
        let tappedGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapped(_:)))
        distributorLabel.isUserInteractionEnabled = true
        distributorLabel.addGestureRecognizer(tappedGesture)
        
        let slug = photoDatas[currentIndex].alternative_slugs.ja
        let jaSlug = slug.replacingOccurrences(of: photoDatas[currentIndex].id, with: "")
        let newSlug = jaSlug.components(separatedBy: CharacterSet(charactersIn: "-")).joined()
        self.title = newSlug
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let photoData = photoDatas[currentIndex]
        let userLink = photoData.user.links.html
        
        if let url = URL(string: userLink) {
            let webVC = WebViewController(url: url)
            present(webVC, animated: true, completion: nil)
        }
    }
    
    @objc func handleTapped(_ sender: UITapGestureRecognizer) {
        let unsplashLink = "https://unsplash.com/ja"
        
        if let url = URL(string: unsplashLink) {
            let webVC = WebViewController(url: url)
            present(webVC, animated: true, completion: nil)
        }
    }

    func loadImage(at index: Int) {
        let photoData = photoDatas[index]
        let imageURL = photoData.urls.regular
        let userName = photoData.user.username
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
    
    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetail" {
            if let photoDetailVC = segue.destination as? PhotoDetailViewController {
                photoDetailVC.photoDatas = photoDatas
                photoDetailVC.currentIndex = currentIndex
            }
        }
    }

}
