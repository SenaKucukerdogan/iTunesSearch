//
//  MovieDetailViewController.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 2.04.2023.
//

import UIKit


/// Controller to show info about single movie
class MovieDetailViewController: UIViewController {
    
    private let viewModel:MovieDetailViewViewModel
    
    init(viewModel: MovieDetailViewViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title

    }
}
