//
//  Order.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 23/07/2021.
//

import Foundation

struct Order: Decodable {
    let id: String?
    let name: String?
    let dish: Dish?
}
