//
//  MoviesViewController.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 29.03.2023.
//

import UIKit

/// Controller to show and search for Movies
final class MoviesViewController: UIViewController, MovieListViewDelegate, UISearchBarDelegate {

    private let movieListView = MovieListView()
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setUpView()
        setUpUI()
        addSearchButton()
        
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
    
    private func setUpUI(){
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(didTapFilter))
        
    }
    
    private func addSearchButton(){
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch(){
//        let vc = SearchViewController(searchKey: .term)
        guard let searchBarText = searchBar.text else { return }
        navigationItem.titleView = searchBar
        Request.listMovieRequest = Request(endpoint: .search, queryParameters: [ParameterKey(searchKey: .media, value: "movie"), ParameterKey(searchKey: .term, value: "\(searchBarText)")])
    }
    
    @objc private func didTapFilter(){
        
    }
    
    // MARK: - MovieListViewDelegate
    func movieListView(_ movieListView: MovieListView, didSelectMovie movie: MovieModel) {
        // Open detail controller for that movie
        
        let viewModel = MovieDetailViewViewModel(movie: movie)
        let detailVC = MovieDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
