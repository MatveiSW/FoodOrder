//
//  CastomNavigationController.swift
//  FoodOrder
//
//  Created by Матвей Авдеев on 19.10.2023.
//

import UIKit
import CoreLocation

class CastomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    private let locationManager = LocationManager() 
    
    private lazy var locationImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "location")
        image.tintColor = .black
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        image.contentMode = .top
        return image
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Не определено"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.setLocalizedDateFormatFromTemplate("dMMMMyyyy")
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        label.text = "\(formattedDate)"
        return label
    }()
    
    private lazy var locationAndDataStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(locationLabel)
        stack.addArrangedSubview(dataLabel)
        stack.spacing = 5
        return stack
    }()
    
    private lazy var personImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "person")
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        locationManager.requestLocationAuthorization()
        locationManager.locationUpdateHandler = { [unowned self] city in
        locationLabel.text = city
        }
        locationManager.startUpdatingLocation()
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        let oneLocationLeftBarButton = UIBarButtonItem(customView: locationImageView)
        let twoLocationLeftBarButton = UIBarButtonItem(customView: locationAndDataStackView)
        
        if viewController is CategoriesViewController {
            viewController.navigationItem.leftBarButtonItems = [oneLocationLeftBarButton, twoLocationLeftBarButton]
        } else if viewController is BascetViewController {
            viewController.navigationItem.leftBarButtonItems = [oneLocationLeftBarButton, twoLocationLeftBarButton]

        }
        
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: personImageView)
    }
        
    
    
}
