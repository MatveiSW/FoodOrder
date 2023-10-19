//
//  BascetCollectionViewCell.swift
//  FoodOrder
//
//  Created by Матвей Авдеев on 13.11.2023.
//

import UIKit

class BascetCollectionViewCell: UICollectionViewCell {
    
    private let networkManager = NetworkManager.shared
    private let bascetManager = BascetManager.shared
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minus"), for: .normal)
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        return button
    }()
    
    private lazy var dishCountLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "1"
        return label
    }()
    
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "cellColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var dishImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var dishNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dishPriceLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    private lazy var dishWeightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var backButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "cellColor")
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var dishPriceAndWeightStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 3
        stack.addArrangedSubview(dishPriceLabel)
        stack.addArrangedSubview(dishWeightLabel)
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var dishInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.addArrangedSubview(dishNameLabel)
        stack.addArrangedSubview(dishPriceAndWeightStackView)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var buttonsAndCountLabelStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(minusButton)
        stack.addArrangedSubview(dishCountLabel)
        stack.addArrangedSubview(plusButton)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalCentering
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBackView()
        addDishImageView()
        addDishInfoStackView()
        addBackButtonView()
        addButtonsAndCountLabelStackView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(dish: Dish) {
        guard let dishImageUrl = URL(string: dish.imageUrl) else { return }
        networkManager.fetchImage(withUrl: dishImageUrl, andImage: dishImageView)
        
        dishNameLabel.text = dish.name
        dishPriceLabel.text = "\(dish.price) ₽"
        dishWeightLabel.text = "· \(dish.weight)г"
        
    }
    
    private func addBackView() {
        contentView.addSubview(backView)
        NSLayoutConstraint.activate(
            [
                backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                backView.widthAnchor.constraint(equalToConstant: contentView.frame.height - 20)
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
    
    private func addDishInfoStackView() {
        contentView.addSubview(dishInfoStackView)
        NSLayoutConstraint.activate(
            [
                dishInfoStackView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
                dishInfoStackView.leadingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 10),
                dishInfoStackView.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2 - 32)
            ]
        )
    }
    
    private func addBackButtonView() {
        contentView.addSubview(backButtonView)
        NSLayoutConstraint.activate(
            [
                backButtonView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
                backButtonView.leadingAnchor.constraint(equalTo: dishInfoStackView.trailingAnchor, constant: 10),
                backButtonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                backButtonView.heightAnchor.constraint(equalToConstant: contentView.frame.height / 2 - 10)
            ]
        )
    }
    
    private func addButtonsAndCountLabelStackView() {
        backButtonView.addSubview(buttonsAndCountLabelStackView)
        NSLayoutConstraint.activate(
            [
                buttonsAndCountLabelStackView.topAnchor.constraint(equalTo: backButtonView.topAnchor, constant: 5),
                buttonsAndCountLabelStackView.leadingAnchor.constraint(equalTo: backButtonView.leadingAnchor, constant: 5),
                buttonsAndCountLabelStackView.trailingAnchor.constraint(equalTo: backButtonView.trailingAnchor, constant: -5),
                buttonsAndCountLabelStackView.bottomAnchor.constraint(equalTo: backButtonView.bottomAnchor, constant: -5)
            ]
        )
    }
    
    
    
}
