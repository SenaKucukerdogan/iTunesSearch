//
//  MovieModel.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 30.03.2023.
//

import Foundation

struct MovieModel:Codable{
    
    let wrapperType:WrapperType
    let kind:Kind
    let artistId:Int?
    let trackId:Int
    let artistName:String
    let trackName:String
    let artworkUrl100:String
    let releaseDate:String
    let country:String
    let shortDescription:String?
    
}
