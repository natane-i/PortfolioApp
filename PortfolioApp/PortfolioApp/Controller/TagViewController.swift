//
//  TagViewController.swift
//  PortfolioApp
//
//  Created by spark-01 on 2024/06/28.
//

import UIKit

class TagViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var colorTagCollectionView: UICollectionView!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    var photos: [String] = []
    let unsplashColorAPI = UnsplashColorAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorTagCollectionView.delegate = self
        colorTagCollectionView.dataSource = self
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
        
        imageFethcer(tag: .black)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tagCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagImageCell", for: indexPath) as! TagCollectionViewCell
            
            let imageURL = photos[indexPath.item]
            cell.configure(with: imageURL)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorTagCell", for: indexPath) as! ColorTagCollectionViewCell
            
            let tag = ColorTags.allCases[indexPath.row]
            cell.colorLabel.text = tag.rawValue
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == colorTagCollectionView {
            let selectedTag = ColorTags.allCases[indexPath.row]
            unsplashColorAPI.fetchUnsplashAPI(for: selectedTag) { [weak self] images in
                DispatchQueue.main.async {
                    self?.photos = images
                    print(selectedTag.rawValue)
                    self?.tagCollectionView.reloadData()
                }
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagCollectionView {
            return photos.count
        } else {
            return ColorTags.allCases.count
        }
    }
    
    func imageFethcer(tag: ColorTags) {
        unsplashColorAPI.fetchUnsplashAPI(for: tag) { [weak self] images in
            DispatchQueue.main.async {
                self?.photos = images
                self?.tagCollectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToInfoFromTag" {
            if let photoInfoVC = segue.destination as? PhotoInfoViewController,
               let selectedIndexPath = tagCollectionView.indexPathsForSelectedItems?.first {
                photoInfoVC.imageURLs = photos
                photoInfoVC.currentIndex = selectedIndexPath.item
            }
        }
    }
}

extension TagViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tagCollectionView {
            let topCellWidth = collectionView.bounds.width
            let otherCellWidth = (topCellWidth - 18.0) / 2
            
            switch indexPath.row {
            case 0:
                return CGSize(width: topCellWidth, height: topCellWidth)
            default:
                return CGSize(width: otherCellWidth, height: otherCellWidth)
            }
        } else {
            let labelSize = (collectionView.bounds.width - 18.0) / 2
            return CGSize(width: labelSize, height: labelSize)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9.0
    }
    
}
