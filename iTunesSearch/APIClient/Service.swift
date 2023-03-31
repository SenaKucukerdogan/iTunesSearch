//
//  MainService.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 29.03.2023.
//

import Foundation

/// Primary API service object iTunes Search data
final class MainService {
    
    /// Shared singleton instance
    static let shared = MainService()
    
    private init() { }
        
    /// Send API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback with data or error
    public func execute(_ request: MainRequest, completion: @escaping (Result<String, Error>) -> Void){
        
    }
}
