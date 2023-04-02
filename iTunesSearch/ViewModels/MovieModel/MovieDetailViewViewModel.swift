//
//  MovieDetailViewViewModel.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 2.04.2023.
//

import Foundation

final class MovieDetailViewViewModel{
    
    private let movie:MovieModel
    
    init(movie: MovieModel){
        self.movie = movie
    }
    
    public var requestUrl: URL?{
        return URL(string: movie.artworkUrl100)
    }
    
    public var title: String{
        movie.artistName.uppercased()
    }
    
    
    public func fetchMovieData(){
        guard let url = requestUrl, let request = Request(url: url) else{
            print("Failed to create")
            return
        }
        print(request.url!)
    }
    
}
