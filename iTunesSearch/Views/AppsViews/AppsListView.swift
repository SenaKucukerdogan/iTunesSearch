//
//  AppsListView.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 2.04.2023.
//

import UIKit

protocol AppsListViewDelegate: AnyObject{
    func appsListView(_ appsListView: AppsListView, didSelectApps apps: AppsModel)
}

class AppsListView: UIView {
    
    public weak var delegate: AppsListViewDelegate?
    
    private let viewModel = AppsListViewModel()
    
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
        collectionView.register(AppsCollectionViewCell.self, forCellWithReuseIdentifier: AppsCollectionViewCell.cellIdentifier)
//        collectionView.register(AppsFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
//                                withReuseIdentifier: AppsFooterLoadingCollectionReusableView.identifier)
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
        viewModel.fetchApps()
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

extension AppsListView: AppsListViewModelDelegate{
    func didSelectApps(_ apps: AppsModel) {
        delegate?.appsListView(self, didSelectApps: apps)
    }
    
    func didLoadInitialAppss() {

        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData() // Initial fetch Apps
        UIView.animate(withDuration: 0.4){
            self.collectionView.alpha = 1
        }
    }
        
}
