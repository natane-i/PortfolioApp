//
//  WebViewController.swift
//  PortfolioApp
//
//  Created by spark-01 on 2024/07/03.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    lazy var webView: WKWebView = {
          let webConfiguration = WKWebViewConfiguration()
          let webView = WKWebView(frame: view.bounds, configuration: webConfiguration)
          webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          return webView
      }()
    
    var url: URL?
        
        init(url: URL) {
            self.url = url
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        
        guard let url = url else {
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }

}
