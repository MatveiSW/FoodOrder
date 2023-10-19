//
//  ViewController.swift
//  FoodOrder
//
//  Created by Матвей Авдеев on 19.10.2023.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    private let identifier = "categoriesCell"
    private let networkManager = NetworkManager.shared
    
    private var categories: Categories?
    
    private lazy var categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width - 32, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addCategoriesCollectionView()
        fetchCategories()
    }

    private func fetchCategories() {
        networkManager.fetch(Categories.self, withUrl: Link.categories.url) { [weak self] result in
            switch result {
                
            case .success(let categoriesData):
                self?.categories = categoriesData
                DispatchQueue.main.async {
                    self?.categoriesCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func addCategoriesCollectionView() {
        view.addSubview(categoriesCollectionView)
        NSLayoutConstraint.activate(
            [
                categoriesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                categoriesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
   
}

extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories?.сategories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CategoriesCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(category: categories?.сategories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dishesVC = DishesViewController()
        dishesVC.title = categories?.сategories[indexPath.row].name
        navigationController?.pushViewController(dishesVC, animated: true)
    }
    
    
}

