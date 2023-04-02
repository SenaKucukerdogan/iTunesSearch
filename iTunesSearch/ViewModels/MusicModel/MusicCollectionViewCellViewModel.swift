//
//  MusicCollectionViewCellViewModel.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 2.04.2023.
//

import Foundation

final class MusicCollectionViewCellViewModel{
    
    public  let collectionName: String
    public let country: String
    public let date:String
    public let musicImageUrl: URL?

    
    // MARK: - Init
    
    init(collectionName: String, country: String, date: String ,musicImageUrl: URL?){
        self.collectionName = collectionName
        self.country = country
        self.date = date
        self.musicImageUrl = musicImageUrl
        
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void){
        guard let url = musicImageUrl else { completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
}
