//
//  Categories.swift
//  FoodOrder
//
//  Created by Матвей Авдеев on 19.10.2023.
//

import Foundation

struct Categories: Decodable {
    let сategories: [Category]
}

struct Category: Decodable {
    let id: Int
    let name: String
    let imageUrl: String
}


