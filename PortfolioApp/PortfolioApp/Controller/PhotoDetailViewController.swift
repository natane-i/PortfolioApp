//
//  PhotoDetailViewController.swift
//  PortfolioApp
//
//  Created by spark-01 on 2024/06/25.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var photoData: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        loadImage(imageURL: photoData)
        
        setupScrollView()
        setupTapGestureRecognizer()
    }
    
    func loadImage(imageURL: String) {
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
    
    private func setupScrollView() {
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2.5
    }

    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: imageView)
        let currentScale = scrollView.zoomScale
        let newScale = currentScale == 1.0 ? scrollView.maximumZoomScale : scrollView.minimumZoomScale

        let zoomRect = zoomRectForScale(scale: newScale, center: tapLocation)
        scrollView.zoom(to: zoomRect, animated: true)
    }

    private func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        let size = CGSize(width: scrollView.bounds.size.width / scale,
                          height: scrollView.bounds.size.height / scale)
        let origin = CGPoint(x: center.x - (size.width / 2.0),
                             y: center.y - (size.height / 2.0))
        return CGRect(origin: origin, size: size)
    }
    
}

extension PhotoDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
