//
//  MoviesViewController.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 29.03.2023.
//

import UIKit

/// Controller to show and search for Movies
final class MoviesViewController: UIViewController, MovieListViewDelegate {

    private let movieListView = MovieListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView(){
        movieListView.delegate = self
        view.addSubview(movieListView)
        
        NSLayoutConstraint.activate([
            movieListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            movieListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            movieListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - MovieListViewDelegate
    func movieListView(_ movieListView: MovieListView, didSelectMovie movie: MovieModel) {
        // Open detail controller for that movie
        
        let viewModel = MovieDetailViewViewModel(movie: movie)
        let detailVC = MovieDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
