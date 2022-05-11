//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Dumitru Rahmaniuc on 28.04.2022.
//

import UIKit
import SDWebImage

class MainTVCell: UITableViewCell {

    static let identifier = "MainTVCell"

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .cyan
        return label
    }()
    
    private lazy var dateLabel: UILabel  = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .gray
        
        return label
    }()
    
    public lazy var mainImage: UIImageView = {
        let iv = UIImageView()
//        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 10
        iv.layer.borderWidth = 1
        iv.layer.borderColor = CGColor(gray: 1, alpha: 1)
        iv.layer.masksToBounds = true
        return iv
    }()


    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(red: 33/255, green: 35/255, blue: 50/255, alpha: 1)
        
        applyConstraints()
    }
    
    
    private func applyConstraints(){
        contentView.addSubviews(nameLabel, dateLabel, mainImage)
        
        nameLabel.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        dateLabel.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        mainImage.snp.makeConstraints{
            $0.top.equalToSuperview().offset(5)
            $0.bottom.equalTo(nameLabel.snp.top).offset(-5)
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
            $0.centerX.equalToSuperview()
//            $0.size.equalTo(100)
        }
    }
    
    public func configure(with  model: LaunchViewModel){
        guard let url = URL(string: "\(model.launchPoster)") else {return}
        mainImage.sd_setImage(with: url, completed: nil)
        nameLabel.text = model.launchName
        dateLabel.text = model.launchDate
        
        if model.launchPoster.contains("flickr"){
            mainImage.contentMode = .scaleAspectFill
        }
        if model.launchPoster.contains("imgur"){
            mainImage.contentMode = .scaleAspectFit
        }
        if model.launchPoster.contains("spacex"){
            mainImage.contentMode = .scaleAspectFill
        }
        
    }
    
 
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
