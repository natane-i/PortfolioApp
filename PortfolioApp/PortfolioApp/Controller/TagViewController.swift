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
    
    var photoDatas: [PhotoData] = []
    var photos: [String] = []
    var labels: [String] = []
    let unsplashAPI = UnsplashAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
        
        imageFethcer(tag: .red)
        
        for (index, button) in colorTagButtons.enumerated() {
            button.tag = index
            button.addTarget(self, action: #selector(colorTagButtonTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc func colorTagButtonTapped(_ sender: UIButton) {
        let selectedTag = ColorTags.allCases[sender.tag]
        imageFethcer(tag: selectedTag)
    }
    
    func imageFethcer(tag: ColorTags) {
        unsplashAPI.fetchUnsplashColorAPI(for: tag) { [weak self] result in
            DispatchQueue.main.async {
                self?.photoDatas = result
                self?.tagCollectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagImageCell", for: indexPath) as! TagCollectionViewCell
            
        let photoData = photoDatas[indexPath.item]
        let imageURL = photoData.urls.regular
        let userName = photoData.user.name
        cell.configure(with: imageURL, userName: userName)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoDatas.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToInfoFromTag" {
            if let photoInfoVC = segue.destination as? PhotoInfoViewController,
               let selectedIndexPath = tagCollectionView.indexPathsForSelectedItems?.first {
                photoInfoVC.photoDatas = photoDatas
                photoInfoVC.currentIndex = selectedIndexPath.item
            }
        }
    }
}

extension TagViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let topCellWidth = collectionView.bounds.size.width
        let otherCellWidth = (topCellWidth - 18.0) / 2
        print(topCellWidth, otherCellWidth)

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
