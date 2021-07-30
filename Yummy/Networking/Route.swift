//
//  Route.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 23/07/2021.
//

import Foundation

enum Route {
    
    static let baseUrl = "https://yummie.glitch.me/"
    
    case fetchAllCategories
    case placeOrder(String)
    
    var description: String {
        switch self {
            case .fetchAllCategories: return "/dish-categories"
            case .placeOrder(let dishId): return "/order/\(dishId)"
        }
    }
}
