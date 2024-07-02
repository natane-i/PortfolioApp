//
//  HomeViewController.swift
//  PortfolioApp
//
//  Created by spark-01 on 2024/06/25.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photoDatas: [PhotoData] = []
    let unsplashAPI = UnsplashAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        imageFethcer()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestImageCell", for: indexPath) as! CollectionViewCell
        
        let photoData = photoDatas[indexPath.item]
        let imageURL = photoData.urls.regular
        let userName = photoData.user.name
        cell.configure(with: imageURL, userName: userName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoDatas.count
    }
    
    func imageFethcer() {
        unsplashAPI.fetchUnsplashAPI() { [weak self] result in
            DispatchQueue.main.async {
                self?.photoDatas = result
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToInfo" {
            if let photoInfoVC = segue.destination as? PhotoInfoViewController,
               let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                photoInfoVC.photoDatas = photoDatas
                photoInfoVC.currentIndex = selectedIndexPath.item
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let topCellWidth = collectionView.bounds.width
        let otherCellWidth = (topCellWidth - 18.0) / 2
        
        switch indexPath.row {
        case 0:
            return CGSize(width: topCellWidth, height: topCellWidth)
        default:
            return CGSize(width: otherCellWidth, height: otherCellWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
    }
    
}

