//
//  AppsDetailViewViewModel.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 2.04.2023.
//

import Foundation

final class AppsDetailViewViewModel{
    
    private let apps:AppsModel
    
    init(apps: AppsModel){
        self.apps = apps
    }
    
    public var requestUrl: URL?{
        return URL(string: apps.artworkUrl100)
    }
    
    public var title: String{
        apps.artistName.uppercased()
    }
    
    
    public func fetchAppsData(){
        guard let url = requestUrl, let request = Request(url: url) else{
            print("Failed to create")
            return
        }
        print(request.url!)
    }
    
}
