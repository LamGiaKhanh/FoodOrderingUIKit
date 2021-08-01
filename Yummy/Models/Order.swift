//
//  Order.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 23/07/2021.
//

import Foundation

struct Order: Decodable {
    var id: String?
    var user: String?
    var detail: OrderDetail?
    var status: String?
    var time: String?
    var total: String?
}
