//
//  Dish.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 22/07/2021.
//

import Foundation

struct Dish: Codable {
    var id : String?
    var name : String?
    var description : String?
    var image : String?
    var cost : String?
    var tag: String?
    
    func formattedVND() -> String {
        guard let costFormat = cost else {
            return "#NULL"
        }
        return "\(costFormat).000VND"
    }
    
}
