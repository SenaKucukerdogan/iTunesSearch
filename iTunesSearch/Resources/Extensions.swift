//
//  Extensions.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 1.04.2023.
//

import UIKit

extension UIView{
    
    func addSubviews(_ views: UIView...){
        views.forEach{(
            addSubview($0)
        )}
    }
}
