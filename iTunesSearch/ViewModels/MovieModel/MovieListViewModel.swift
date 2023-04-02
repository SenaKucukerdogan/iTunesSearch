//
//  MovieListViewModel.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 1.04.2023.
//

import UIKit

protocol MovieListViewModelDelegate: AnyObject{
    func didLoadInitialMovies()
    func didSelectMovie(_ movie: MovieModel)
}


/// View Model to handle movie list view logic
final class MovieListViewModel:NSObject{
    
    public weak var delegate: MovieListViewModelDelegate?
    
//    private var isLoadingMoreMovies = false
    
    private var movies: [MovieModel] = []{
        didSet{
            for movie in movies{
                let viewModel = MovieCollectionViewCellViewModel(collectionName: movie.trackName, country: movie.country, date: movie.releaseDate, movieImageUrl: URL(string: movie.artworkUrl100))
                
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [MovieCollectionViewCellViewModel] = []
    private var apiResultCount : Int?
    
    public func fetchMovies(){
        Service.shared.execute(.listMovieRequest, expecting: GetAllMovieResponse.self) { [weak self] result in
            switch result {
                case .success(let responseModel):
                let results = responseModel.results
                let resultCount = responseModel.resultCount
                self?.movies = results
                self?.apiResultCount = resultCount
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialMovies()
                }
                case .failure(let error):
                    print(String(describing: error))
            }
        }
    }

    /// Paginate if additional movies are needed
//    public func fetchAdditionalMovies(url: URL){
//        // fetch movies
//        isLoadingMoreMovies = true
//        guard let request = Request(url: url) else { isLoadingMoreMovies = false; return }
//
//        Service.shared.execute(request, expecting: GetAllMovieResponse.self) { result in
//            switch result{
//            case .success(let success):
//                print("dfvdf")
//            case .failure(let failure):
//                print("dmkdfmv")
//            }
//        }
//    }
    
//    public var shouldShowLoadMoreIndicator: Bool{
//        return apiResultCount != nil
//    }
}

// MARK: - CollectionView
extension MovieListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier,
                                                           for: indexPath) as? MovieCollectionViewCell
        else { fatalError("Unsupported cell")}
        cell.configure(with: cellViewModels[indexPath.row])

        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        guard kind == UICollectionView.elementKindSectionFooter,
//        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MovieFooterLoadingCollectionReusableView.identifier,
//                                                                           for: indexPath) as? MovieFooterLoadingCollectionReusableView
//        else { fatalError("Unsupported")}
//        footer.startAnimating()
//        
//        return footer
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        guard shouldShowLoadMoreIndicator else { return .zero }
//        return CGSize(width: collectionView.frame.width, height: 50)
//    }
//    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        return CGSize(width: bounds.width, height: bounds.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        delegate?.didSelectMovie(movie)
    }
    
}

//// MARK: - ScrollView
//extension MovieListViewModel: UIScrollViewDelegate{
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        guard shouldShowLoadMoreIndicator, !isLoadingMoreMovies, !cellViewModels.isEmpty
////        let url = URL(string: "")
//        else { return }
//        
//        let offset = scrollView.contentOffset.y
//        let totalContentHeight = scrollView.contentSize.height
//        let totalScrollViewFixedHeight = scrollView.frame.size.height
//
//        if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120){
//            print("should start fetching more")
////            fetchAdditionalMovies(url: url)
//
//        }
//    }
//}
//
