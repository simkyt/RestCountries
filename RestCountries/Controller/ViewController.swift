//
//  ViewController.swift
//  RestCountries
//
//  Created by arturs.olekss on 15/11/2023.
//

import UIKit

class ViewController: UITableViewController, UISearchResultsUpdating {
    
    private let cellID = "cell"
    private let countryAllUrl = "https://restcountries.com/v3.1/all"
    private var countries: [Country] = []
    
    private var filteredCountries: [Country] = [] // for the search
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
        
        NetworkManager.fetchData(url: countryAllUrl){
            countries in
            self.countries = countries
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        setupSearchController()
    }
    
    private func setupView(){
        view.backgroundColor = .secondarySystemBackground
        tableView.register(CountryTableViewCell.self,forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        
//        self.title = "Countries"
//        let titleImage = UIImage(systemName: "mappin.and.ellipse")
//        let imageView = UIImageView(image:titleImage)
//        self.navigationItem.titleView = imageView
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor:UIColor.label]
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.label]
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = .label
        
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search countries"
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredCountries = countries.filter { country in
                return country.name.common?.lowercased().contains(searchText.lowercased()) ?? false
            }
        } else {
            filteredCountries = countries
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = searchController.isActive ? filteredCountries.count : countries.count
        
        if count == 0 {
            tableView.setEmptyView(title: "Fetching the countries...", message: "Please wait...")
            navigationItem.searchController = nil
            navigationItem.title = nil
        } else {
            tableView.restoreTableViewStyle()
            navigationItem.searchController = searchController
            navigationItem.title = "Countries"
        }
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID,for: indexPath) as? CountryTableViewCell else{
            return UITableViewCell()
        }
        
        let country = searchController.isActive ? filteredCountries[indexPath.row] : countries[indexPath.row]
        cell.setupUI(withDataFrom: country)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = searchController.isActive ? filteredCountries[indexPath.row] : countries[indexPath.row]
        
        let detailViewController = CountryDetailViewController()
        detailViewController.country = selectedCountry
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let titleLabel = UILabel()
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.label
        titleLabel.font = UIFont(name: "Futura-Medium", size: 18)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            
            activityIndicator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            activityIndicator.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor)
        ])
        
        titleLabel.text = title
        
        self.backgroundView = emptyView
        self.separatorStyle = .singleLine
    }
    
    func restoreTableViewStyle() {
        self.backgroundView = nil
    }
}

