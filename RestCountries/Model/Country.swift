//
//  Country.swift
//  RestCountries
//
//  Created by arturs.olekss on 15/11/2023.
//

import Foundation


struct Name:Codable{
    let common,official:String?
}

struct Country:Codable{
    let name:Name
    let region: String?
    let flags: Flags
    let population: Int?
    let capital: [String]?
    let continents: [Continent]
}

enum Continent: String, Codable {
    case africa = "Africa"
    case antarctica = "Antarctica"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case oceania = "Oceania"
    case southAmerica = "South America"
}
