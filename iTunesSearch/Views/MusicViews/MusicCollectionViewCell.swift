//
//  MusicCollectionViewCell.swift
//  iTunesSearch
//
//  Created by Sena Küçükerdoğan on 2.04.2023.
//

import UIKit

/// Single cell for a Music
final class MusicCollectionViewCell: UICollectionViewCell{
    
   static let cellIdentifier = "MusicCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let collectionNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubviews(imageView,collectionNameLabel, countryLabel, dateLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: CGFloat(UIScreen.main.bounds.width/2)),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            imageView.rightAnchor.constraint(equalTo: collectionNameLabel.leftAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            collectionNameLabel.heightAnchor.constraint(equalToConstant: 40),
            collectionNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            collectionNameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 5),
            collectionNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            collectionNameLabel.bottomAnchor.constraint(equalTo: countryLabel.topAnchor, constant: -5),
            
            countryLabel.heightAnchor.constraint(equalToConstant: 40),
            countryLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 5),
            countryLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            countryLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -5),
            
            dateLabel.heightAnchor.constraint(equalToConstant: 40),
            dateLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 5),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
                        
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        collectionNameLabel.text = nil
        countryLabel.text = nil
        dateLabel.text = nil
    }
    
    public func configure(with viewModel: MusicCollectionViewCellViewModel){
        collectionNameLabel.text = viewModel.collectionName
        countryLabel.text = viewModel.country
        dateLabel.text = viewModel.date
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
}
