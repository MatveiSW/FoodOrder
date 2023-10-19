//
//  DishCategoriesCollectionViewCell.swift
//  FoodOrder
//
//  Created by Матвей Авдеев on 03.11.2023.
//

import UIKit

class DishCategoriesCollectionViewCell: UICollectionViewCell {
        
    private lazy var dishCategoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        label.text = "Все меню"
        label.textAlignment = .center
        return label
    }()
    
    var isSelectedCell: Bool = false {
        didSet {
            dishCategoryLabel.textColor = isSelectedCell ? .white : .black
            contentView.backgroundColor = isSelectedCell ? UIColor(named: "selectedCellColor") : UIColor(named: "cellColor")
            contentView.layer.cornerRadius = 10
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addDishCategoryLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(teg: String) {
        dishCategoryLabel.text = teg 
    }
    
    private func addDishCategoryLabel() {
        contentView.addSubview(dishCategoryLabel)
        NSLayoutConstraint.activate(
            [
                dishCategoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                dishCategoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                dishCategoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                dishCategoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                
            ]
        )
    }
}
