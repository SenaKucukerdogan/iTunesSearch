//
//  MainService.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 29.03.2023.
//

import Foundation

/// Primary API service object iTunes Search data
final class Service {
    
    /// Shared singleton instance
    static let shared = Service()
    
    private init() { }
       
    enum ServiceError: Error{
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Send API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we expect tp get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(_ request: Request, expecting type: T.Type, completion: @escaping (Result<T , Error>) -> Void){
        
        guard let urlRequest = self.request(from: request) else { completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else { completion(.failure(error ?? ServiceError.failedToGetData))
                return
            }
            // Decode response
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    private func request(from request: Request) -> URLRequest? {
        guard let url = request.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = request.httpMethod
        return request
    }
}
