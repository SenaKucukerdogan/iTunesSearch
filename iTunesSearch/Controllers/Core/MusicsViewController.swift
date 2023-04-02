//
//  MusicsViewController.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 29.03.2023.
//

import UIKit

/// Controller to show and search for Musics
final class MusicsViewController: UIViewController, MusicListViewDelegate {

    private let musicListView = MusicListView()
    private let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        addSearchButton()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(didTapFilter))
        

    }
    
    private func setUpView(){
        musicListView.delegate = self
        view.addSubview(musicListView)
        
        NSLayoutConstraint.activate([
            musicListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            musicListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            musicListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            musicListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
    }
    
    @objc private func didTapFilter(){
        
    }
    
    // MARK: - MusicListViewDelegate
    func musicListView(_ musicListView: MusicListView, didSelectMusic music: MusicModel) {
        // Open detail controller for that Music
        
        let viewModel = MusicDetailViewViewModel(music: music)
        let detailVC = MusicDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
