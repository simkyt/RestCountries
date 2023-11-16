//
//  CountryDetailViewController.swift
//  RestCountries
//
//  Created by Simonas Kytra on 16/11/2023.
//

import UIKit
import SDWebImage

class CountryDetailViewController : UIViewController {
    var country: Country?
    private let countryDetailView = CountryDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .secondarySystemBackground
        
        title = country?.name.common
        view.addSubview(countryDetailView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        countryDetailView.imageView.addGestureRecognizer(tapGesture)
        countryDetailView.imageView.isUserInteractionEnabled = true
        
        countryDetailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countryDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            countryDetailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            countryDetailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            countryDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        if let urlString = country?.flags.png, let url = URL(string: urlString) {
            loadImage(from: url)
        }
    }
    
    func loadImage(from url: URL) {
        SDWebImageManager.shared.loadImage(with: url, options: [], progress: nil) { [weak self] (image, data, error, cacheType, finished, imageURL) in
            DispatchQueue.main.async {
                if let image = image {
                    self?.countryDetailView.updateImage(image)
                    self?.countryDetailView.updateUI(withDataFrom: self!.country!)
                } else {
                    self?.countryDetailView.updateImage(UIImage(named: "notfound.jpg"))
                }
            }
        }
    }
    
    @objc func imageTapped() {
        let alert = UIAlertController(title: "What's in the flag?", message: country?.flags.alt, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
