//
//  CategoriesCollectionViewCell.swift
//  FoodOrder
//
//  Created by Матвей Авдеев on 19.10.2023.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    private let networkManager = NetworkManager.shared
    
    private lazy var categoryImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true 
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Helvetica", size: 20)
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addCategoryImageView()
        addCategoryLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(category: Category?) {
        guard let categoryUrl = URL(string: category?.imageUrl ?? "") else { return }
        networkManager.fetchImage(withUrl: categoryUrl, andImage: categoryImageView)
        categoryLabel.text = category?.name
    }
    
    private func addCategoryImageView() {
        contentView.addSubview(categoryImageView)
        NSLayoutConstraint.activate(
            [
                categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                categoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                categoryImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        )
    }
    
    private func addCategoryLabel() {
        categoryImageView.addSubview(categoryLabel)
        NSLayoutConstraint.activate(
            [
                categoryLabel.topAnchor.constraint(equalTo: categoryImageView.topAnchor, constant: 15),
                categoryLabel.leadingAnchor.constraint(equalTo: categoryImageView.leadingAnchor, constant: 15),
            ]
        )
    }
}
