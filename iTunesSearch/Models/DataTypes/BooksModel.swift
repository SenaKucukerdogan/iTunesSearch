//
//  BooksModel.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 30.03.2023.
//

import Foundation

struct BooksModel:Codable{
    
    let artworkUrl100:String
    let genres:[String]
    let description:String
    let releaseDate:String
    let trackId:Int
    let trackName:String
    let kind:Kind
    let artistId:Int
    let artistName:String
    
}
