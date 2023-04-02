//
//  AppsCollectionViewCellViewModel.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 2.04.2023.
//

import Foundation

final class AppsCollectionViewCellViewModel{
    
    public  let collectionName: String
    public let country: String
    public let date:String
    public let appsImageUrl: URL?

    
    // MARK: - Init
    
    init(collectionName: String, country: String, date: String ,appsImageUrl: URL?){
        self.collectionName = collectionName
        self.country = country
        self.date = date
        self.appsImageUrl = appsImageUrl
        
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void){
        guard let url = appsImageUrl else { completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
}
