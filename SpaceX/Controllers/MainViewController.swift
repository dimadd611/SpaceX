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
        tb.backgroundColor = .white
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        configureLayout()
        getLaunch()
        view.backgroundColor = .red
    }
    
    func configureLayout(){
        view.addSubviews(mainTableView)
        
        mainTableView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(30)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func getLaunch(){
        APICaller.shared.getLaunchInfo{ [weak self] result in
            switch result{
            case.success(let launces):
                self?.launches = launces
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
        cell.configure(with: LaunchViewModel(launchName: launch.name , launchDate: launch.dateUTC))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

