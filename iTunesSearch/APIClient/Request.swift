//
//  MainRequest.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 29.03.2023.
//

import Foundation

/// Object that represents a single API call
final class Request {
    // Base url
    // Endpoint
    // Query parameters
    // https://itunes.apple.com/search?term=jack+johnson
    
    
    /// API Constant
    private struct Constant {
        static let baseUrl = "https://itunes.apple.com/search"
    }
    
    private let endpoint: Endpoint
    private let queryParameters: [ParameterKey]
    public let httpMethod = "GET"
    
    /// Constructed url for the api request in string format
    private var urlString: String {
        var urlPath = Constant.baseUrl
        urlPath += "?"
      
        if !queryParameters.isEmpty{
            //key=value&key=value
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.searchKey)=\(value)"
            }).joined(separator: "&")
            
            urlPath += argumentString
        }
        return urlPath
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - queryParameters: Collection of query parameters
    public init(endpoint: Endpoint, queryParameters: [ParameterKey] = []) {
        self.endpoint = endpoint
        self.queryParameters = queryParameters
    }
}

extension Request{
    static let listMovieRequest = Request(endpoint: .search, queryParameters: [ParameterKey(searchKey: .media, value: "movie"), ParameterKey(searchKey: .term, value: "j")])
}
