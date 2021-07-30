//
//  String + Extension.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 22/07/2021.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
