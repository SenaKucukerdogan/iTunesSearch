//
//  BookListViewModel.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 2.04.2023.
//

import UIKit

protocol BookListViewModelDelegate: AnyObject{
    func didLoadInitialBooks()
    func didSelectBook(_ book: BooksModel)
}


/// View Model to handle Book list view logic
final class BookListViewModel:NSObject{
    
    public weak var delegate: BookListViewModelDelegate?
    
    private var isLoadingMoreBooks = false
    
    private var books: [BooksModel] = []{
        didSet{
            for book in books{
                let viewModel = BookCollectionViewCellViewModel(collectionName: book.trackName, country: book.artistName, date: book.releaseDate, bookImageUrl: URL(string: book.artworkUrl100))
                
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [BookCollectionViewCellViewModel] = []
    private var apiResultCount : Int?
    

    public func fetchBooks(){
        Service.shared.execute(.listBookRequest, expecting: GetAllBookResponse.self) { [weak self] result in
            switch result {
                case .success(let responseModel):
                let results = responseModel.results
                let resultCount = responseModel.resultCount
                self?.books = results
                self?.apiResultCount = resultCount
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialBooks()
                }
                case .failure(let error):
                    print(String(describing: error))
            }
        }
    }
    
    
    /// Paginate if additional Books are needed
//    public func fetchAdditionalBooks(url: URL){
//        // fetch Books
//        isLoadingMoreBooks = true
//        guard let request = Request(url: url) else { isLoadingMoreBooks = false; return }
//
//        Service.shared.execute(request, expecting: GetAllBookResponse.self) { result in
//            switch result{
//            case .success(let success):
//                print("dfvdf")
//            case .failure(let failure):
//                print("dmkdfmv")
//            }
//        }
//    }
    
    public var shouldShowLoadMoreIndicator: Bool{
        return apiResultCount != nil
    }
}

// MARK: - CollectionView
extension BookListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.cellIdentifier,
                                                           for: indexPath) as? BookCollectionViewCell
        else { fatalError("Unsupported cell")}
        cell.configure(with: cellViewModels[indexPath.row])

        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        guard kind == UICollectionView.elementKindSectionFooter,
//        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BookFooterLoadingCollectionReusableView.identifier,
//                                                                           for: indexPath) as? BookFooterLoadingCollectionReusableView
//        else { fatalError("Unsupported")}
//        footer.startAnimating()
//        
//        return footer
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else { return .zero }
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        return CGSize(width: bounds.width, height: bounds.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let book = books[indexPath.row]
        delegate?.didSelectBook(book)
    }
    
}

//// MARK: - ScrollView
//extension BookListViewModel: UIScrollViewDelegate{
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        guard shouldShowLoadMoreIndicator, !isLoadingMoreBooks, !cellViewModels.isEmpty
////        let url = URL(string: "")
//        else { return }
//        
//        let offset = scrollView.contentOffset.y
//        let totalContentHeight = scrollView.contentSize.height
//        let totalScrollViewFixedHeight = scrollView.frame.size.height
//
//        if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120){
//            print("should start fetching more")
////            fetchAdditionalBooks(url: url)
//
//        }
//    }
//}

