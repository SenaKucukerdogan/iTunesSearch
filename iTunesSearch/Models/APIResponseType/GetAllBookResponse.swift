//
//  GetAllBookResponse.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 2.04.2023.
//

import Foundation

struct GetAllBookResponse: Codable{
    let resultCount:Int?
    let results:[BooksModel]
}
