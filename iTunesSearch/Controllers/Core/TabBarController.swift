//
//  ViewController.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 29.03.2023.
//

import UIKit

/// Controller to house tabs and root tab controllers
final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpTabs()
    }

    private func setUpTabs(){

        let moviesVC = MoviesViewController()
        let musicsVC = MusicsViewController()
        let booksVC  = BookViewController()
        let appsVC   = AppsViewController()
        
        let moviesNC = UINavigationController(rootViewController: moviesVC)
        let musicsNC = UINavigationController(rootViewController: musicsVC)
        let booksNC  = UINavigationController(rootViewController: booksVC)
        let appsNC   = UINavigationController(rootViewController: appsVC)
        
        moviesNC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film"), tag: 1)
        musicsNC.tabBarItem = UITabBarItem(title: "Musics", image: UIImage(systemName: "music.note"), tag: 2)
        booksNC.tabBarItem = UITabBarItem(title: "Books", image: UIImage(systemName: "book"), tag: 3)
        appsNC.tabBarItem = UITabBarItem(title: "Apps", image: UIImage(systemName: "app"), tag: 4)
        
        setViewControllers([moviesNC, musicsNC, booksNC, appsNC], animated: true)
    }
}

