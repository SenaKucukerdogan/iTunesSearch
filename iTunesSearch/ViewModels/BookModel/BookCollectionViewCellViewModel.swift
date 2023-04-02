//
//  BookCollectionViewCellViewModel.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 2.04.2023.
//

import Foundation

final class BookCollectionViewCellViewModel{
    
    public  let collectionName: String
    public let country: String
    public let date:String
    public let bookImageUrl: URL?

    
    // MARK: - Init
    
    init(collectionName: String, country: String, date: String ,bookImageUrl: URL?){
        self.collectionName = collectionName
        self.country = country
        self.date = date
        self.bookImageUrl = bookImageUrl
        
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void){
        guard let url = bookImageUrl else { completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
}
