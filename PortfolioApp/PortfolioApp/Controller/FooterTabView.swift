//
//  FooterTabView.swift
//  PortfolioApp
//
//  Created by spark-01 on 2024/07/01.
//

import UIKit

enum FooterTab {
    case home
    case tag
//    case info
}

protocol FooterTabViewDelegate: AnyObject {
    func footerTabView(_ footerTabView: FooterTabView, didselectTab: FooterTab)
}

class FooterTabView: UIView {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    var delegate: FooterTabViewDelegate?
    
    @IBAction func didTapHome(_ sender: Any) {
        delegate?.footerTabView(self, didselectTab: .home)
    }
    
    @IBAction func didTapTag(_ sender: Any) {
        delegate?.footerTabView(self, didselectTab: .tag)
    }
    
    @IBAction func didTapInfo(_ sender: Any) {
//        delegate?.footerTabView(self, didselectTab: .info)
    }
    
    // カスタムビューの初期化メソッド
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        load()
        setup()
    }
    
    // 影を背景につけて丸みをつけるコード
    func setup() {
        shadowView.layer.cornerRadius = frame.height / 2
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.4
        shadowView.layer.shadowRadius = 8
        shadowView.layer.shadowOffset = CGSize(width: 4, height: 4)
     
        contentView.layer.cornerRadius = frame.height / 2
        contentView.layer.masksToBounds = true
    }
    
    // nibファイルをViewController上に表示するコード
    func load() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
    
    
    
}
