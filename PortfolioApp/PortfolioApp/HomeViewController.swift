//
//  HomeViewController.swift
//  PortfolioApp
//
//  Created by spark-01 on 2024/06/25.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos: [String] = []
    let unsplashAPI = UnsplashAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
        imageFethcer()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestImageCell", for: indexPath) as! CollectionViewCell
        
        let imageURL = photos[indexPath.item]
        cell.configure(with: imageURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func imageFethcer() {
        unsplashAPI.fetchUnsplashAPI() { [weak self] images in
            DispatchQueue.main.async {
                self?.photos = images
                self?.collectionView.reloadData()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let topCellWidth = collectionView.bounds.width
        let otherCellWidth = (collectionView.bounds.width - 12) / 2
        
        switch indexPath.row {
        case 0:
            return CGSize(width: topCellWidth, height: topCellWidth)
        default:
            return CGSize(width: otherCellWidth, height: otherCellWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
}

