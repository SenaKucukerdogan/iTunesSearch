//
//  AppsViewController.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 29.03.2023.
//

import UIKit

/// Controller to show and search for Appss
final class AppsViewController: UIViewController, AppsListViewDelegate {

    private let appsListView = AppsListView()
    private let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        addSearchButton()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(didTapFilter))
        

    }
    
    private func setUpView(){
        appsListView.delegate = self
        view.addSubview(appsListView)
        
        NSLayoutConstraint.activate([
            appsListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            appsListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            appsListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            appsListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func addSearchButton(){
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch(){
//        let vc = SearchViewController(searchKey: .term)
        navigationItem.titleView = searchBar
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapFilter(){
        
    }
    
    // MARK: - AppsListViewDelegate
    func appsListView(_ appsListView: AppsListView, didSelectApps apps: AppsModel) {
        // Open detail controller for that Apps
        
        let viewModel = AppsDetailViewViewModel(apps: apps)
        let detailVC = AppsDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
