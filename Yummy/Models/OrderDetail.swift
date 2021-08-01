//
//  OrderDetail.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 01/08/2021.
//

import Foundation

struct OrderDetail: Decodable {
    var dishes: [Dish]
    var amount: [Int]
}
