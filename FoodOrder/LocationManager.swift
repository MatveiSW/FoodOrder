//
//  LocationManager.swift
//  FoodOrder
//
//  Created by Матвей Авдеев on 03.11.2023.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
   
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    var locationUpdateHandler: ((String) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    print("Ошибка обратного геокодирования: \(error.localizedDescription)")
                    return
                }
                
                if let placemark = placemarks?.first, let city = placemark.locality {
                    self.locationUpdateHandler?(city)
                }
            }
        }
    }
}

