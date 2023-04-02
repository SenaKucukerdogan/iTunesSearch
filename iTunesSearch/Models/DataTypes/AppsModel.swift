//
//  AppsModel.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 30.03.2023.
//

import Foundation

struct AppsModel:Codable{
    
    let artworkUrl100:String
    let kind:String?
    let description:String
    let artistId:Int
    let artistName:String
    let genres:[String]
    let releaseDate:String
    let trackId:Int
    let trackName:String
    let version:String
    let wrapperType:String?
    
}
