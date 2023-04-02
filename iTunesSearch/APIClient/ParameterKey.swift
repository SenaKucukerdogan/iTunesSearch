//
//  ParameterKey.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 31.03.2023.
//

import Foundation

struct ParameterKey {
    
    let searchKey:SearchKey
    let value:String?
    
    public init(searchKey: SearchKey, value: String){
        self.searchKey = searchKey
        self.value = value
    }
    

}
