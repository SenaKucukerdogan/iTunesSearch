//
//  GetMovieResponse.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 31.03.2023.
//

import Foundation

struct GetAllMovieResponse: Codable{
    let resultCount:Int?
    let results:[MovieModel]
}
