//
//  AppsDetailViewController.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 2.04.2023.
//
import UIKit


/// Controller to show info about single Apps
class AppsDetailViewController: UIViewController {
    
    private let viewModel:AppsDetailViewViewModel
    private let detailView = AppsDetailView()
    
    // MARK: - Init
    init(viewModel: AppsDetailViewViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        view.addSubview(detailView)
        addConstraints()
        viewModel.fetchAppsData()
    }

    private func addConstraints(){
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
