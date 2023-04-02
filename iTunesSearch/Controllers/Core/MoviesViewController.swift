//
//  MoviesViewController.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 29.03.2023.
//

import UIKit

/// Controller to show and search for Movies
final class MoviesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let request = Request(endpoint: .search, queryParameters: [ParameterKey(searchKey: .media, value: "movie"), ParameterKey(searchKey: .term, value: "Jack+Johnson")])
//        print(request.url)
//        
//        Service.shared.execute(request, expecting: MovieModel.self) { result in
//            switch result {
//            case .success:
//                break
//            case .failure(let error):
//                print(String(describing: error))
//            }
//        }
        Service.shared.execute(.listMovieRequest, expecting: GetAllMovieResponse.self) { result in
            switch result {
                case .success(let model):
                print(String(describing: model.resultCount))
                case .failure(let error):
                    print(String(describing: error))
            }
        }
    }
}
