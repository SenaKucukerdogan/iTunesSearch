//
//  MusicModel.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 30.03.2023.
//

import Foundation

struct MusicModel:Codable{
    
    let wrapperType:WrapperType
    let kind:Kind
    let artistId:Int
    let collectionId:Int
    let trackId:Int
    let artistName:String
    let collectionName:String
    let trackName:String
    let artworkUrl100:String
    let releaseDate:String
    let country:String
    
}
