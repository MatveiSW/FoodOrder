//
//  DishDetailsView.swift
//  FoodOrder
//
//  Created by Матвей Авдеев on 09.11.2023.
//

import UIKit

class DishDetailsView: UIView {
    
    private let networkManager = NetworkManager.shared
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "cellColor")
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var dishImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        return button
    }()
    
    lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heartButton"), for: .normal)
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.addArrangedSubview(heartButton)
        stack.addArrangedSubview(closeButton)
        return stack
    }()
    
    lazy var dishNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        return label
    }()
    
    lazy var dishPriceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var dishWeightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.addArrangedSubview(dishPriceLabel)
        stack.addArrangedSubview(dishWeightLabel)
        return stack
    }()
    
    lazy var dishDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    lazy var addDishButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.backgroundColor = UIColor(named: "selectedCellColor")
        button.setTitle("Добавить в корзину", for: .normal)
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonAndLabelStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.addArrangedSubview(dishDescriptionLabel)
        stack.addArrangedSubview(addDishButton)
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 20
        addBackgroundView()
        addDishImageView()
        addButtonStackView()
        addDishNameLabel()
        addLabelStackView()
        addButtonAndLabelStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(dish: Dish?) {
        guard let dish else { return }
        guard let imageUrl = URL(string: dish.imageUrl) else { return }
        networkManager.fetchImage(withUrl: imageUrl , andImage: dishImageView)
        dishNameLabel.text = dish.name
        dishPriceLabel.text = "\(dish.price) ₽"
        dishWeightLabel.text = "· \(dish.weight)г"
        dishDescriptionLabel.text = dish.description
    }
    
    private func addBackgroundView() {
        addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            backgroundView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
    }

    
    private func addDishImageView() {
        backgroundView.addSubview(dishImageView)
        NSLayoutConstraint.activate(
            [
                dishImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 16),
                dishImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 50),
                dishImageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -40),
                dishImageView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -20)
            ]
        )
    }
    
    private func addButtonStackView() {
        backgroundView.addSubview(buttonStackView)
        NSLayoutConstraint.activate(
            [
                buttonStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
                buttonStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -10)
            ]
        )
    }
    
    private func addDishNameLabel() {
        addSubview(dishNameLabel)
        NSLayoutConstraint.activate(
            [
                dishNameLabel.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 10),
                dishNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                dishNameLabel.heightAnchor.constraint(equalToConstant: 20)
            ]
        )
    }
    
    private func addLabelStackView() {
        addSubview(labelStackView)
        NSLayoutConstraint.activate(
            [
                labelStackView.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 10),
                labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
            ]
        )
    }
    
    private func addButtonAndLabelStackView() {
        addSubview(buttonAndLabelStackView)
        NSLayoutConstraint.activate(
            [
                buttonAndLabelStackView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 10),
                buttonAndLabelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                buttonAndLabelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                buttonAndLabelStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
                addDishButton.heightAnchor.constraint(equalToConstant: 50)
            ]
        )
    }
    
}
