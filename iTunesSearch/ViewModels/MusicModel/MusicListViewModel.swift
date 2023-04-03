//
//  MusicListViewModel.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 2.04.2023.
//

import Foundation
import UIKit

protocol MusicListViewModelDelegate: AnyObject{
    func didLoadInitialMusics()
    func didSelectMusic(_ Music: MusicModel)
}


/// View Model to handle Music list view logic
final class MusicListViewModel:NSObject{
    
    public weak var delegate: MusicListViewModelDelegate?
    
    private var isLoadingMoreMusics = false
    
    private var musics: [MusicModel] = []{
        didSet{
            for music in musics{
                let viewModel = MusicCollectionViewCellViewModel(collectionName: music.collectionName, country: music.country, date: music.releaseDate, musicImageUrl: URL(string: music.artworkUrl100))
                
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [MusicCollectionViewCellViewModel] = []
    private var apiResultCount : Int?
    

    public func fetchMusics(){
        Service.shared.execute(.listMusicRequest, expecting: GetAllMusicResponse.self) { [weak self] result in
            switch result {
                case .success(let responseModel):
                let results = responseModel.results
                let resultCount = responseModel.resultCount
                self?.musics = results
                self?.apiResultCount = resultCount
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialMusics()
                }
                case .failure(let error):
                    print(String(describing: error))
            }
        }
    }
    
    
    /// Paginate if additional Musics are needed
//    public func fetchAdditionalMusics(url: URL){
//        // fetch Musics
//        isLoadingMoreMusics = true
//        guard let request = Request(url: url) else { isLoadingMoreMusics = false; return }
//
//        Service.shared.execute(request, expecting: GetAllMusicResponse.self) { result in
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
extension MusicListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.cellIdentifier,
                                                           for: indexPath) as? MusicCollectionViewCell
        else { fatalError("Unsupported cell")}
        cell.configure(with: cellViewModels[indexPath.row])

        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        guard kind == UICollectionView.elementKindSectionFooter,
//        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MusicFooterLoadingCollectionReusableView.identifier,
//                                                                           for: indexPath) as? MusicFooterLoadingCollectionReusableView
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
        let music = musics[indexPath.row]
        delegate?.didSelectMusic(music)
    }
    
}

//// MARK: - ScrollView
//extension MusicListViewModel: UIScrollViewDelegate{
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        guard shouldShowLoadMoreIndicator, !isLoadingMoreMusics, !cellViewModels.isEmpty
//       let url = URL(string: "")
//        else { return }
//        
//        let offset = scrollView.contentOffset.y
//        let totalContentHeight = scrollView.contentSize.height
//        let totalScrollViewFixedHeight = scrollView.frame.size.height
//
//        if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120){
//            print("should start fetching more")
//          fetchAdditionalMusics(url: url)
//
//        }
//    }
//}

