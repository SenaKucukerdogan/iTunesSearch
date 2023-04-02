//
//  BooksViewController.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 29.03.2023.
//

import UIKit

/// Controller to show and search for Books
final class BooksViewController: UIViewController, BookListViewDelegate {

    private let bookListView = BookListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(didTapFilter))
        

    }
    
    private func setUpView(){
        bookListView.delegate = self
        view.addSubview(bookListView)
        
        NSLayoutConstraint.activate([
            bookListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bookListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            bookListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            bookListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc private func didTapFilter(){
        
    }
    
    // MARK: - BookListViewDelegate
    func bookListView(_ bookListView: BookListView, didSelectBook book: BooksModel) {
        // Open detail controller for that Book
        
        let viewModel = BookDetailViewViewModel(book: book)
        let detailVC = BookDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
