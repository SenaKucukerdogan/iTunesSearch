//
//  GetAllAppsResponse.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 2.04.2023.
//

import Foundation

struct GetAllAppsResponse: Codable{
    let resultCount:Int?
    let results:[AppsModel]
}
