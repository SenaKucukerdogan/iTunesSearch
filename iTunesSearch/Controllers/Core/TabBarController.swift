//
//  ViewController.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 29.03.2023.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpTabs()
    }

    private func setUpTabs(){
        let appsVC   = AppsViewController()
        let moviesVC = MoviesViewController()
        let musicsVC = MusicsViewController()
        let booksVC  = BooksViewController()
        
        let appsNC   = UINavigationController(rootViewController: appsVC)
        let moviesNC = UINavigationController(rootViewController: moviesVC)
        let musicsNC = UINavigationController(rootViewController: musicsVC)
        let booksNC  = UINavigationController(rootViewController: booksVC)
        
        appsNC.tabBarItem = UITabBarItem(title: "Apps", image: UIImage(systemName: "app"), tag: 1)
        moviesNC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film"), tag: 2)
        musicsNC.tabBarItem = UITabBarItem(title: "Musics", image: UIImage(systemName: "music.note"), tag: 3)
        booksNC.tabBarItem = UITabBarItem(title: "Books", image: UIImage(systemName: "book"), tag: 4)
        
        setViewControllers([appsNC, moviesNC, musicsNC, booksNC], animated: true)
    }
}

