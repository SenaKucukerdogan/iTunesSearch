//
//  SearchViewController.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 2.04.2023.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let searchKey: SearchKey
    
    init(searchKey: SearchKey) {
        self.searchKey = searchKey
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
