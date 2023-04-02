//
//  AppsListViewModel.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 2.04.2023.
//

import UIKit

protocol AppsListViewModelDelegate: AnyObject{
    func didLoadInitialAppss()
    func didSelectApps(_ apps: AppsModel)
}


/// View Model to handle Apps list view logic
final class AppsListViewModel:NSObject{
    
    public weak var delegate: AppsListViewModelDelegate?
    
    private var isLoadingMoreAppss = false
    
    private var apps: [AppsModel] = []{
        didSet{
            for apps in apps{
                let viewModel = AppsCollectionViewCellViewModel(collectionName: apps.trackName, country: apps.version, date: apps.releaseDate, appsImageUrl: URL(string: apps.artworkUrl100))
                
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [AppsCollectionViewCellViewModel] = []
    private var apiResultCount : Int?
    

    public func fetchApps(){
        Service.shared.execute(.listAppsRequest, expecting: GetAllAppsResponse.self) { [weak self] result in
            switch result {
                case .success(let responseModel):
                let results = responseModel.results
                let resultCount = responseModel.resultCount
                self?.apps = results
                self?.apiResultCount = resultCount
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialAppss()
                }
                case .failure(let error):
                    print(String(describing: error))
            }
        }
    }
    
    
    /// Paginate if additional Appss are needed
//    public func fetchAdditionalAppss(url: URL){
//        // fetch Appss
//        isLoadingMoreAppss = true
//        guard let request = Request(url: url) else { isLoadingMoreAppss = false; return }
//
//        Service.shared.execute(request, expecting: GetAllAppsResponse.self) { result in
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
extension AppsListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsCollectionViewCell.cellIdentifier,
                                                           for: indexPath) as? AppsCollectionViewCell
        else { fatalError("Unsupported cell")}
        cell.configure(with: cellViewModels[indexPath.row])

        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        guard kind == UICollectionView.elementKindSectionFooter,
//        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AppsFooterLoadingCollectionReusableView.identifier,
//                                                                           for: indexPath) as? AppsFooterLoadingCollectionReusableView
//        else { fatalError("Unsupported")}
//        footer.startAnimating()
//        
//        return footer
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        guard shouldShowLoadMoreIndicator else { return .zero }
//        return CGSize(width: collectionView.frame.width, height: 50)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        return CGSize(width: bounds.width, height: bounds.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let apps = apps[indexPath.row]
        delegate?.didSelectApps(apps)
    }
    
}

//// MARK: - ScrollView
//extension AppsListViewModel: UIScrollViewDelegate{
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        guard shouldShowLoadMoreIndicator, !isLoadingMoreAppss, !cellViewModels.isEmpty
//       let url = URL(string: "")
//        else { return }
//        
//        let offset = scrollView.contentOffset.y
//        let totalContentHeight = scrollView.contentSize.height
//        let totalScrollViewFixedHeight = scrollView.frame.size.height
//
//        if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120){
//            print("should start fetching more")
//           fetchAdditionalAppss(url: url)
//
//        }
//    }
//}

