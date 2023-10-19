//
//  ViewController.swift
//  FoodOrder
//
//  Created by Матвей Авдеев on 19.10.2023.
//

import UIKit

class DishesViewController: UIViewController {
    
    private let dishCategoriesIdentifier = "dishCategoriesIdentifier"
    private let dishesIdentifier = "dishesIdentifier"
    private let networkManager = NetworkManager.shared
    private let bascetManager = BascetManager.shared
    
    private var dishesList: Dishes?
    private var selectedTeg = "Все меню"
    private var uniqueTegs: [String] = []
    private var filteredDishes: [Dish] = []
    private var selectedIndexPath: IndexPath!
    
    private lazy var dishCategoriesCollectionView: UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: 150, height: 40)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(DishCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: dishCategoriesIdentifier)
        return collection
    }()
    
    private lazy var dishesCollesctionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width / 3 - 18, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(DishesCollectionViewCell.self, forCellWithReuseIdentifier: dishesIdentifier)
        return collection
    }()
    
    private lazy var backgroundOverlay: UIView = {
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.alpha = 0.0
        return overlay
    }()
    
    private lazy var dishDetailsView: DishDetailsView = {
        let dishDetailView = DishDetailsView()
        dishDetailView.translatesAutoresizingMaskIntoConstraints = false
        return dishDetailView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addDishCategoriesCollectionView()
        addDishesCollectionView()
        settingNavigationBar()
        fetchDishes()
        addBackgroundOverlay()
    }
    
    private func fetchDishes() {
        networkManager.fetch(Dishes.self, withUrl: Link.dish.url) { [weak self] result in
            switch result {
                
            case .success(let dishesData):
                self?.dishesList = dishesData
                
                let uniqueTegsSet = Set(dishesData.dishes.flatMap { $0.tegs })
                self?.uniqueTegs = Array(uniqueTegsSet.sorted())
                
                DispatchQueue.main.async {
                    self?.dishCategoriesCollectionView.reloadData()
                    self?.updateFilteredDishes()
                    self?.dishesCollesctionView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func settingNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(backButton))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func showDishDetailsView(for indexPath: IndexPath) {
        view.addSubview(dishDetailsView)
        
        dishDetailsView.configure(dish: filteredDishes[indexPath.row])
        dishDetailsView.closeButton.addTarget(self, action: #selector(hideDishDetailsView), for: .touchUpInside)
        dishDetailsView.addDishButton.addTarget(self, action: #selector(bascetAddDishButton), for: .touchUpInside)
        
        dishDetailsView.alpha = 0.0
        UIView.animate(withDuration: 0.3) {
            self.dishDetailsView.alpha = 1.0
            self.showBackgroundOverlay()
        }
        
        NSLayoutConstraint.activate([
            dishDetailsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dishDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dishDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dishDetailsView.heightAnchor.constraint(equalToConstant: view.frame.height / 2)
        ])
        
    }
    
    private func showBackgroundOverlay() {
        UIView.animate(withDuration: 0.3) {
            self.backgroundOverlay.alpha = 1.0
        }
    }
    
    private func addDishCategoriesCollectionView() {
        view.addSubview(dishCategoriesCollectionView)
        NSLayoutConstraint.activate(
            [
                dishCategoriesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                dishCategoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                dishCategoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                dishCategoriesCollectionView.heightAnchor.constraint(equalToConstant: 70)
            ]
        )
    }
    
    private func addBackgroundOverlay() {
        view.addSubview(backgroundOverlay)
        NSLayoutConstraint.activate(
            [
                backgroundOverlay.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backgroundOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
    
    private func addDishesCollectionView() {
        view.addSubview(dishesCollesctionView)
        NSLayoutConstraint.activate(
            [
                dishesCollesctionView.topAnchor.constraint(equalTo: dishCategoriesCollectionView.bottomAnchor),
                dishesCollesctionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                dishesCollesctionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                dishesCollesctionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
    
    private func updateFilteredDishes() {
        filteredDishes = dishesList?.dishes.filter { $0.tegs.contains(selectedTeg) } ?? []
    }
    
    @objc private func hideDishDetailsView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.dishDetailsView.alpha = 0.0
            self.backgroundOverlay.alpha = 0.0
        }) { _ in
            self.dishDetailsView.removeFromSuperview()
        }
    }
    
    @objc private func backButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func bascetAddDishButton() {
        bascetManager.bascetList.append(filteredDishes[selectedIndexPath.row])
        hideDishDetailsView()
    }
    
}

extension DishesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == dishCategoriesCollectionView ? uniqueTegs.count : filteredDishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == dishCategoriesCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dishCategoriesIdentifier, for: indexPath) as? DishCategoriesCollectionViewCell else { return UICollectionViewCell() }
            
            cell.backgroundColor = UIColor(named: "cellColor")
            cell.layer.cornerRadius = 10
            
            cell.configure(teg: uniqueTegs[indexPath.row])
            cell.isSelectedCell = uniqueTegs[indexPath.row] == selectedTeg
            
            return cell
            
        } else if collectionView == dishesCollesctionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dishesIdentifier, for: indexPath) as? DishesCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configure(dish: filteredDishes[indexPath.row])
            cell.layer.cornerRadius = 15
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == dishCategoriesCollectionView {
            
            selectedTeg = uniqueTegs[indexPath.row]
            updateFilteredDishes()
            collectionView.reloadData()
            dishesCollesctionView.reloadData()
            
        } else if collectionView == dishesCollesctionView {
            selectedIndexPath = indexPath
            showDishDetailsView(for: indexPath)
        }
    }
}
