//
//  CountryDetailView.swift
//  RestCountries
//
//  Created by Simonas Kytra on 16/11/2023.
//

import UIKit

class CountryDetailView: UIView {
    let scrollView = UIScrollView()
    let contentStackView = UIStackView()
    let imageStackView = UIStackView()
    let labelStackView = UIStackView()
    
    let imageView = UIImageView()
    let officialNameLabel = UILabel()
    
    let populationLabel = UILabel()
    let capitalLabel = UILabel()
    let continentLabel = UILabel()
    
    let activityIndicator = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        officialNameLabel.translatesAutoresizingMaskIntoConstraints = false
        populationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        officialNameLabel.textAlignment = .center
        officialNameLabel.numberOfLines = 0
        officialNameLabel.lineBreakMode = .byWordWrapping
        officialNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 25
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.axis = .vertical
        imageStackView.spacing = 20
        labelStackView.axis = .vertical
        labelStackView.spacing = 10
        
        addSubview(scrollView)
        
        contentStackView.addArrangedSubview(imageStackView)
        contentStackView.addArrangedSubview(labelStackView)
        
        scrollView.addSubview(contentStackView)
        
        imageStackView.addArrangedSubview(activityIndicator)
        imageStackView.addArrangedSubview(imageView)
        imageStackView.addArrangedSubview(officialNameLabel)
        
        labelStackView.addArrangedSubview(populationLabel)
        labelStackView.addArrangedSubview(capitalLabel)
        labelStackView.addArrangedSubview(continentLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor, constant: -20),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            imageView.centerXAnchor.constraint(equalTo: contentStackView.centerXAnchor),
//            imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
//            imageView.heightAnchor.constraint(equalToConstant: 300),
        ])
        
        imageView.contentMode = .scaleAspectFit
        activityIndicator.startAnimating()
    }

    func updateImage(_ image: UIImage?) {
        activityIndicator.stopAnimating()
        imageView.image = image
    }

    func updateUI(withDataFrom: Country) {
        if (withDataFrom.name.common != withDataFrom.name.official) {
            officialNameLabel.text = withDataFrom.name.official ?? "Unknown"
        } else {
            officialNameLabel.isHidden = true
        }
        
        populationLabel.text = "Population: " + String(withDataFrom.population ?? 0)
        
        if let capitalsArray = withDataFrom.capital {
            let joinedCapitals = capitalsArray.joined(separator: ", ")
            let capitalLabelString = capitalsArray.count == 1 ? "Capital: " : "Capitals: "
            capitalLabel.text = "\(capitalLabelString)\(joinedCapitals)"
        }
        
        let continentNames = withDataFrom.continents.map { $0.rawValue }
        let joinedContinents = continentNames.joined(separator: ", ")
        let continentLabelString = continentNames.count == 1 ? "Continent: " : "Continents: "
        continentLabel.text = "\(continentLabelString)\(joinedContinents)"
    }
}
