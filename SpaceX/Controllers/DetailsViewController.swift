//
//  DetailsViewController.swift
//  SpaceX
//
//  Created by Dumitru Rahmaniuc on 11.05.2022.
//

import UIKit
import WebKit


class DetailsViewController: UIViewController {
    
    private lazy var titleLbael: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.text = "EWE NEMNOJKO"
        return label
    }()
    
    
    private lazy var webView: WKWebView = {
        let wv = WKWebView()
        return wv
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        view.addSubviews(webView, titleLbael)
        
        webView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(200)
            $0.width.equalToSuperview()
        }
        
        titleLbael.snp.makeConstraints{
            $0.top.equalTo(webView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
        
       
    }
    
    func configure(with model: DescriptionViewModel){
        titleLbael.text = model.titleName
        
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.video)") else {return}
        
        webView.load(URLRequest(url: url))
    }
    

}
