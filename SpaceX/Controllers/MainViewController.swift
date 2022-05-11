//
//  ViewController.swift
//  SpaceX
//
//  Created by Dumitru Rahmaniuc on 11.05.2022.
//

import UIKit
import SnapKit


class MainViewController: UIViewController {
    
    private var launches: [Launch] = [Launch]()
    
    private lazy var mainTableView: UITableView = {
        let tb = UITableView()
        tb.register(MainTVCell.self, forCellReuseIdentifier: MainTVCell.identifier)
        tb.backgroundColor = UIColor(red: 33/255, green: 35/255, blue: 50/255, alpha: 1)
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        configureLayout()
        getLaunch()
        configureNavBar()
        view.backgroundColor = UIColor(red: 33/255, green: 35/255, blue: 50/255, alpha: 1)
    }
    
    func configureNavBar(){
        title = "SpaceX"
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "play.fill"), style: .plain, target: self, action: #selector(goDescrip))
    }
    
    @objc func goDescrip(){
        self.navigationController?.pushViewController(DetailsViewController(), animated: true)
    }
    
    func configureLayout(){
        view.addSubviews(mainTableView)
        
        mainTableView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func getLaunch(){
        APICaller.shared.getLaunchInfo{ [weak self] result in
            switch result{
            case.success(let launces):
                self?.launches = launces.reversed()
                DispatchQueue.main.async {
                    self?.mainTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }



}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTVCell.identifier, for: indexPath) as? MainTVCell else {
            return UITableViewCell()
        }
        let launch = launches[indexPath.row]
        
        let date = Date(timeIntervalSince1970: Double(launch.dateUnix))
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                dateFormatter.locale = NSLocale.current
                dateFormatter.dateFormat = "MMMM d, yyyy"
                let strDate = dateFormatter.string(from: date)

        
        
        cell.configure(with: LaunchViewModel(launchName: launch.name , launchDate: strDate, launchPoster: (launch.links.flickr.original?.first ?? launch.links.patch.small) ?? "https://www.spacex.com/static/images/share.jpg"))
        
        
        
                
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

