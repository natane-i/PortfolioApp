//
//  InfoViewController.swift
//  PortfolioApp
//
//  Created by spark-01 on 2024/07/02.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tappedGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapped(_:)))
        logoImage.isUserInteractionEnabled = true
        logoImage.addGestureRecognizer(tappedGesture)
    }
    
    @objc func handleTapped(_ sender: UITapGestureRecognizer) {
        let unsplashLink = "https://unsplash.com/ja"
        
        if let url = URL(string: unsplashLink) {
            let webVC = WebViewController(url: url)
            present(webVC, animated: true, completion: nil)
        }
    }



}
