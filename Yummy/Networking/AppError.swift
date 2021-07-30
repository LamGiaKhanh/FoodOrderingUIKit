//
//  AppError.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 24/07/2021.
//

import Foundation

enum AppError: LocalizedError {
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "Unknown Error"
        case .invalidUrl:
            return "Invalid Url"
        case .serverError(_):
            return "Server Error"
        }
    }
}
