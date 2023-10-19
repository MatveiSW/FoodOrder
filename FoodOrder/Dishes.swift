//
//  Dishes.swift
//  FoodOrder
//
//  Created by Матвей Авдеев on 06.11.2023.
//

import Foundation

struct Dishes: Decodable {
    let dishes: [Dish]
}

struct Dish: Decodable {
    let id: Int
    let name: String
    let price: Int
    let weight: Int
    let description: String
    let imageUrl: String
    let tegs: [String]
}
