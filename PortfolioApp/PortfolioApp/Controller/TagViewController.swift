//
//  TagViewController.swift
//  PortfolioApp
//
//  Created by spark-01 on 2024/06/28.
//

import UIKit

class TagViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    @IBOutlet var colorTagButtons: [UIButton]!
    
    var photos: [String] = []
    let unsplashColorAPI = UnsplashColorAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
        
        for (index, button) in colorTagButtons.enumerated() {
            button.tag = index
            let selectedTag = ColorTags.allCases[button.tag]
            button.addTarget(self, action: #selector(colorTagButtonTapped(_:)), for: .touchUpInside)
        }
        
        
        imageFethcer(tag: .red)
    }
    
    @objc func colorTagButtonTapped(_ sender: UIButton) {
        let selectedTag = ColorTags.allCases[sender.tag]
        DispatchQueue.global().async {
            self.unsplashColorAPI.fetchUnsplashAPI(for: selectedTag) { [weak self] images in
                DispatchQueue.main.async {
                    self?.photos = images
                    self?.tagCollectionView.reloadData()
                    self?.tagCollectionView.collectionViewLayout.invalidateLayout()
                }
            }
        }
    }
    
    func imageFethcer(tag: ColorTags) {
        unsplashColorAPI.fetchUnsplashAPI(for: tag) { [weak self] images in
            DispatchQueue.main.async {
                self?.photos = images
                self?.tagCollectionView.reloadData()
                self?.tagCollectionView.collectionViewLayout.invalidateLayout()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagImageCell", for: indexPath) as! TagCollectionViewCell
        print("Dequeuing cell at indexPath: \(indexPath)")
        print("Cell frame: \(cell.frame)")
            print("Image view frame: \(cell.imageView.frame)")
            
        let imageURL = photos[indexPath.item]
        cell.configure(with: imageURL)
        print(cell.imageView.frame)
        print(cell.bounds.size)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
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

        let contentInsets = collectionView.contentInset
        let topCellWidth = collectionView.bounds.width - contentInsets.left - contentInsets.right
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
    
}
