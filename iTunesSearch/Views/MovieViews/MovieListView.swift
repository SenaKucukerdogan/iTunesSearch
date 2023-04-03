//
//  MovieListView.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 1.04.2023.
//

import UIKit

protocol MovieListViewDelegate: AnyObject{
    func movieListView(_ movieListView: MovieListView, didSelectMovie movie: MovieModel)
}

class MovieListView: UIView {
    
    public weak var delegate: MovieListViewDelegate?
    
    private let viewModel = MovieListViewModel()
    
    private var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collectionView.isHidden = true
        collectionView.alpha = 1
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.cellIdentifier)
//        collectionView.register(MovieFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
//                                withReuseIdentifier: MovieFooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(collectionView, spinner)
        
        addConstraints()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchMovies()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setUpCollectionView(){
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

extension MovieListView: MovieListViewModelDelegate{
    func didSelectMovie(_ movie: MovieModel) {
        delegate?.movieListView(self, didSelectMovie: movie)
    }
    
    func didLoadInitialMovies() {

        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData() // Initial fetch movie
        UIView.animate(withDuration: 0.4){
            self.collectionView.alpha = 1
        }
    }
        
}
