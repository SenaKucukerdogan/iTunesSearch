//
//  BookDetailViewViewModel.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 2.04.2023.
//

import Foundation

final class BookDetailViewViewModel{
    
    private let book:BooksModel
    
    init(book: BooksModel){
        self.book = book
    }
    
    public var requestUrl: URL?{
        return URL(string: book.artworkUrl100)
    }
    
    public var title: String{
        book.artistName.uppercased()
    }
    
    
    public func fetchBookData(){
        guard let url = requestUrl, let request = Request(url: url) else{
            print("Failed to create")
            return
        }
        print(request.url!)
    }
    
}
