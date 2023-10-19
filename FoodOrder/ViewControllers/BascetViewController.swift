//
//  BascetViewController.swift
//  FoodOrder
//
//  Created by Матвей Авдеев on 13.11.2023.
//

import UIKit

class BascetViewController: UIViewController {

    private let bascetIdentifier = "bascetCell"
    private let bascetManager = BascetManager.shared
    
    private var dishesSum = 0
    
    private lazy var payButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.setTitle("Оплатить \(dishesSum) ₽", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(named: "selectedCellColor")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }() 
    
    private lazy var bascetCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: view.frame.width - 32, height: 100)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(BascetCollectionViewCell.self, forCellWithReuseIdentifier: bascetIdentifier)
        return collection
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dishesSum = bascetManager.calculateSum()
        payButton.setTitle("Оплатить \(dishesSum) ₽", for: .normal)
        
        bascetCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addPayButton()
        addBascetCollectionView()
    }
    
    private func addPayButton() {
        view.addSubview(payButton)
        NSLayoutConstraint.activate(
            [
                payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
                payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                payButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                payButton.heightAnchor.constraint(equalToConstant: 50)
            ]
        )
    }
    
    private func addBascetCollectionView() {
        view.addSubview(bascetCollectionView)
        NSLayoutConstraint.activate(
            [
                bascetCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                bascetCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                bascetCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bascetCollectionView.bottomAnchor.constraint(equalTo: payButton.topAnchor)
            ]
        )
    }
    
}

extension BascetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bascetManager.bascetList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bascetIdentifier, for: indexPath) as? BascetCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(dish: bascetManager.bascetList[indexPath.item])

        return cell
    }
}
