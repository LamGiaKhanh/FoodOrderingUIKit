//
//  AllDishes.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 24/07/2021.
//

import Foundation

struct AllDishes: Decodable {
    let categories: [DishCategory]?
    let populars: [Dish]?
    let specials: [Dish]?
}
