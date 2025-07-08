//
//  failure.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 03/06/25.
//

import Foundation

enum FailureResponse: Error {
    case noInternet
    case invalidURL
    case invalidResponse
    case timeOut
    case noError
    case fileNotFound
}

extension FailureResponse: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return ErrorMessage.noInternet.rawValue
        case .invalidURL:
            return ErrorMessage.invalidURL.rawValue
        case .invalidResponse:
            return ErrorMessage.invalidResponse.rawValue
        case .noError:
            return ErrorMessage.noInternet.rawValue
        case .timeOut:
            return ErrorMessage.noInternet.rawValue
        case .fileNotFound:
            return ErrorMessage.noInternet.rawValue
        }
    }
}
