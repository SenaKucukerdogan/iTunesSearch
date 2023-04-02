//
//  MovieCollectionViewCellViewModel.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 1.04.2023.
//

import Foundation

final class MovieCollectionViewCellViewModel{
    
    public  let collectionName: String
    public let country: String
    public let date:String
    public let movieImageUrl: URL?

    
    // MARK: - Init
    
    init(collectionName: String, country: String, date: String ,movieImageUrl: URL?){
        self.collectionName = collectionName
        self.country = country
        self.date = date
        self.movieImageUrl = movieImageUrl
        
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void){
        guard let url = movieImageUrl else { completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)        
    }
}
