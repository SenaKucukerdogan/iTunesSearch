//
//  Enums.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 30.03.2023.
//

import Foundation

/// Represents unique API endpoint
@frozen enum Endpoint: String{
    case search
    case lookup
}

enum SearchKey:String {
    
    case term
    case country
    case media
    case entity
    case attribute
    case limit
}

enum Media:String {
    
    case movie
    case podcast
    case music
    case musicVideo
    case audiobook
    case shortFilm
    case tvShow
    case software
    case ebook
    case all
}


enum Kind:String, Codable{
    
    case book = "book"
    case album = "album"
    case coached_audio = "coached-audio"
    case feature_movie = "feature-movie"
    case interactive_booklet = "interactive-booklet"
    case music_video = "music-video"
    case pdf_podcast = "pdf podcast"
    case podcast_episode = "podcast-episode"
    case software_package = "software-package"
    case song = "song"
    case tv_episode = "tv_episode"
    
}

enum WrapperType:String, Codable{
    
    case track = "track"
    case collection = "collection"
    case artistFor = "artistFor"
}




