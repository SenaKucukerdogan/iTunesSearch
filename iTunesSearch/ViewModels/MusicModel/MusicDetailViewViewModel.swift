//
//  MusicDetailViewViewModel.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 2.04.2023.
//

import Foundation

final class MusicDetailViewViewModel{
    
    private let music:MusicModel
    
    init(music: MusicModel){
        self.music = music
    }
    
    public var requestUrl: URL?{
        return URL(string: music.artworkUrl100)
    }
    
    public var title: String{
        music.artistName.uppercased()
    }
    
    
    public func fetchMusicData(){
        guard let url = requestUrl, let request = Request(url: url) else{
            print("Failed to create")
            return
        }
        print(request.url!)
    }
    
}
