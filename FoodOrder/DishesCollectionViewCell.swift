//
//  DishesCollectionViewCell.swift
//  FoodOrder
//
//  Created by Матвей Авдеев on 03.11.2023.
//

import UIKit

class DishesCollectionViewCell: UICollectionViewCell {
    
    private let networkManager = NetworkManager.shared
    
    private lazy var dishImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = UIColor(named: "cellColor")
        return image
    }()
    
    private lazy var dishLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.layer.cornerRadius = 3
        label.numberOfLines = 2
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // Не получится использовать dishImageView.backgroundСolor, т.к картинки в api смещены в бок. Было принято решение просто сделать фон в ручную, так же и в bascetCell
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "cellColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBackgroundView()
        addDishImageView()
        addDishLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(dish: Dish?) {
        guard let dishUrl = URL(string: dish?.imageUrl ?? "") else { return }
        networkManager.fetchImage(withUrl: dishUrl, andImage: dishImageView)
        dishLabel.text = dish?.name
    }

    private func addBackgroundView() {
        contentView.addSubview(backView)
        NSLayoutConstraint.activate(
            [
                backView.topAnchor.constraint(equalTo: contentView.topAnchor),
                backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                backView.heightAnchor.constraint(equalToConstant: contentView.frame.height - 40)
            ]
        )
    }
    
    private func addDishImageView() {
        backView.addSubview(dishImageView)
        NSLayoutConstraint.activate(
            [
                dishImageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
                dishImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15),
                dishImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
                dishImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10)
            ]
        )
    }
    
    private func addDishLabel() {
        contentView.addSubview(dishLabel)
        NSLayoutConstraint.activate(
            [
                dishLabel.topAnchor.constraint(equalTo: backView.bottomAnchor, constant: 5),
                dishLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                dishLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ]
        )
    }
    
}
