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
    
    convenience init?(url: URL){
        let string = url.absoluteString
        if !string.contains(Constant.baseUrl){
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constant.baseUrl+"/", with: "")
        if trimmed.contains("/"){
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty{
                let endpointString = components[0]
                if let endpoint = Endpoint(rawValue: endpointString){
                    self.init(endpoint: endpoint)
                }
            }            
        }
        else if trimmed.contains("?"){
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty{
                let endpointString = components[0]
                if let endpoint = Endpoint(rawValue: endpointString){
                    self.init(endpoint: endpoint)
                }
            }
        }
        return nil
    }
}

extension Request{
    static var listMovieRequest = Request(endpoint: .search) //, queryParameters: [ParameterKey(searchKey: .media, value: "movie"), ParameterKey(searchKey: .term, value: "j")])
    static let listMusicRequest = Request(endpoint: .search, queryParameters: [ParameterKey(searchKey: .media, value: "music"), ParameterKey(searchKey: .term, value: "j")])
    static let listBookRequest = Request(endpoint: .search, queryParameters: [ParameterKey(searchKey: .media, value: "ebook"), ParameterKey(searchKey: .term, value: "jack")])
    static let listAppsRequest = Request(endpoint: .search, queryParameters: [ParameterKey(searchKey: .media, value: "software"), ParameterKey(searchKey: .term, value: "jack")])
}
