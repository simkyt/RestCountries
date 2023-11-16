//
//  CountryTableViewCell.swift
//  RestCountries
//
//  Created by Simonas Kytra on 16/11/2023.
//

import UIKit
import SDWebImage

class CountryTableViewCell: UITableViewCell {
    let countryImageView = UIImageView()
    let commonNameLabel = UILabel()
    let regionLabel = UILabel()
    let mainStackView = UIStackView()
    let labelsStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fill
        mainStackView.alignment = .center
        mainStackView.spacing = 20
        
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fill
        labelsStackView.spacing = 5
        
        commonNameLabel.numberOfLines = 0
        commonNameLabel.lineBreakMode = .byWordWrapping
        
        regionLabel.numberOfLines = 0
        regionLabel.lineBreakMode = .byWordWrapping
        regionLabel.font = UIFont.systemFont(ofSize: 12)
        
        [commonNameLabel, regionLabel].forEach { labelsStackView.addArrangedSubview($0) }
        
        [countryImageView, labelsStackView].forEach { mainStackView.addArrangedSubview($0) }
        
        contentView.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        countryImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countryImageView.widthAnchor.constraint(equalToConstant: 45),
            countryImageView.heightAnchor.constraint(equalToConstant: 30),
//            countryImageView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 20),
//            countryImageView.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 20),
//            countryImageView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI (withDataFrom: Country) {
        commonNameLabel.text = withDataFrom.name.common
        regionLabel.text = withDataFrom.region
        countryImageView.sd_setImage(with: URL(string:withDataFrom.flags.png))
    }
}
