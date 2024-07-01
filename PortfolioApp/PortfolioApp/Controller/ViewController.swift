//
//  ViewController.swift
//  PortfolioApp
//
//  Created by spark-01 on 2024/06/25.
//

import UIKit

class ViewController: UIViewController, FooterTabViewDelegate {

    @IBOutlet weak var footerTabView: FooterTabView! {
        didSet {
            footerTabView.delegate = self
        }
    }
    
    var selectedTab: FooterTab = .home
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchViewController(selectedTab: .tag)
    }
    
    private lazy var homeViewController: HomeViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        add(childViewController: viewController)
        return viewController
    }()
    
    private lazy var tagViewController: TagViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "TagViewController") as! TagViewController
        add(childViewController: viewController)
        return viewController
    }()
    
    private func switchViewController(selectedTab: FooterTab) {
        switch selectedTab {
        case .home:
            add(childViewController: homeViewController)
            remove(childViewController: tagViewController)
        case .tag:
            add(childViewController: tagViewController)
            remove(childViewController: homeViewController)
//        case .info:
//
        }
        self.selectedTab = selectedTab
        view.bringSubviewToFront(footerTabView)
    }
    
    // 子ViewControllerを追加する
    private func add(childViewController: UIViewController) {
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.view.frame = view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParent: self)
    }
    
    // 子ViewControllerを削除する
    private func remove(childViewController: UIViewController) {
        childViewController.willMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
    }
    
    func footerTabView(_ footerTabView: FooterTabView, didselectTab: FooterTab) {
       
    }
    
 

}

