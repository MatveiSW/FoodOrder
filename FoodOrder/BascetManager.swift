//
//  BascetManager.swift
//  FoodOrder
//
//  Created by Матвей Авдеев on 16.11.2023.
//

import Foundation

class BascetManager {
    static let shared = BascetManager()
    
    var bascetList: [Dish] = []
    var priceList: [Int] = []

    func calculateSum() -> Int {
        priceList.removeAll()
        for bascet in bascetList {
            priceList.append(bascet.price)
            
        }
        
      return priceList.reduce(0, +)
        
    }
    
    private init() {}
}
