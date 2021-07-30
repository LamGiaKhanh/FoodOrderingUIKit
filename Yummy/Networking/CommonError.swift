//
//  CommonError.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 28/07/2021.
//

import Foundation

public struct CommonError: Error {
    init(_ error: Error? = nil, reason: String? = nil) {
        self.reason = error?.localizedDescription ?? ""
        if reason != nil {
            self.reason = reason ?? ""
        }
    }
    var reason: String = ""
}
