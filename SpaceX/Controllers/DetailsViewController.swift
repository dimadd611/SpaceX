//
//  DetailsViewController.swift
//  SpaceX
//
//  Created by Dumitru Rahmaniuc on 11.05.2022.
//

import UIKit
import WebKit
import RxSwift
import RxGesture


class DetailsViewController: UIViewController {

    
    private lazy var titleLbael: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    
    private lazy var webView: WKWebView = {
        let wv = WKWebView()
        return wv
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        return label
    }()
    
    private lazy var wikiBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Wikipedia", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.rx.tap.bind{
            UIApplication.shared.open(URL(string: "\(self.wiki)")!)
        }
        return button
    }()
    
    
    private lazy var rocketName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.cyan
        return label
    }()
    
    private lazy var payloadMass: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.cyan
        return label
    }()
    
    var name: String
    var vidID: String
    var detail: String
    var date: Int
    var rocket: String
    var wiki: String

    init(name: String, videoID: String, date: Int, details: String, rocketID: String, wikipedia: String){
        self.name = name
        self.vidID = videoID
        self.date = date
        self.detail = details
        self.rocket = rocketID
        self.wiki = wikipedia

        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getRocketDetails(rocketID: rocket)
        configureLayout()
        
    }
    
    func configureLayout(){
        view.backgroundColor = UIColor(red: 33/255, green: 35/255, blue: 50/255, alpha: 1)
        
        view.addSubviews(webView, titleLbael, wikiBtn, rocketName, payloadMass, dateLabel)
        configure()

        webView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(webView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        wikiBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
        
        payloadMass.snp.makeConstraints{
            $0.bottom.equalTo(wikiBtn.snp.top).offset(-30)
            $0.centerX.equalToSuperview()
        }
        
        rocketName.snp.makeConstraints{
            $0.bottom.equalTo(payloadMass.snp.top).offset(-20)
            $0.centerX.equalToSuperview()
        }
        
        titleLbael.snp.makeConstraints{
            $0.top.equalTo(dateLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(350)
        }
    }
    

    
    func configure(){
        titleLbael.text = detail
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(vidID)") else {return}
        webView.load(URLRequest(url: url))
        
        
                let dateform = Date(timeIntervalSince1970: Double(date))
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                dateFormatter.locale = NSLocale.current
                dateFormatter.dateFormat = "MMMM d, yyyy"
                let strDate = dateFormatter.string(from: dateform)
        dateLabel.text = strDate
    }
    

    
    func getRocketDetails(rocketID: String) {
        getRocketInfo(rocketID: rocketID) { rocket in
            DispatchQueue.main.async {
                self.rocketName.text = "Rocket name: \(rocket.name)"
                self.payloadMass.text = "Payload mass: \(String(describing: rocket.payloadWeights.first?.kg ?? 0)) kg"
            }
        }
    }
    
    
    
    
    func getRocketInfo(rocketID: String, completion: @escaping (Rocket) -> ()) {
        
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets/\(self.rocket)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let rocket = try JSONDecoder().decode(Rocket.self, from: data)
                print(rocket)
                completion(rocket)
            }catch{
                print(error)
            }
        }
        task.resume()
    }
    

}
