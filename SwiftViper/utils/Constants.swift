//
//  Constant.swift
//  ProjectOne
//
//  Created by Muhammad Arif on 23/05/25.
//

import Foundation

struct Constants{
    static let randomImage = "https://picsum.photos/500/700"
}

enum ErrorMessage: String {
    case invalidURL = "Invalid URL."
    case noInternet = "Internet not Available."
    case invalidResponse = "Invalid Response."
    case requestTimeOut = "Request time out."
    case noError = "No Error."
    case fileNotFound = "Unable to find file."
    case unknownError = "Unknown error."
    case emptyState = "Please check after some time."
}

enum ResponseCode: Int {
    case success = 200
}

enum NetworkCheckError: Error {
    case noConnection
}
