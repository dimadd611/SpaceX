//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Dumitru Rahmaniuc on 28.04.2022.
//

import UIKit

class MainTVCell: UITableViewCell {

    static let identifier = "MainTVCell"

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        return label
    }()

    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .yellow
        
        applyConstraints()
    }
    
    
    private func applyConstraints(){
        contentView.addSubviews(nameLabel, dateLabel)
        
        nameLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        dateLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    public func configure(with  model: LaunchViewModel){
        nameLabel.text = model.launchName
        dateLabel.text = model.launchDate
    }
    
 
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
