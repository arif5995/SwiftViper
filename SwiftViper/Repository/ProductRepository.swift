//
//  ProductRepository.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 03/06/25.
//

import Foundation

protocol ProductRepositoryProtocol {
    func getProduct(endpoint: String) async throws -> [Product]
    func signIn(endpoint: String, user: UserParam) async throws -> UserResponse
}

class ProductRepository: ProductRepositoryProtocol {
    private var netWorkManager: NetWorkManagerProtocol
    
    init(netWorkManager: NetWorkManagerProtocol) {
        self.netWorkManager = netWorkManager
    }
    
    func signIn(endpoint: String, user: UserParam) async throws -> UserResponse {
        do {
            let response =  try await netWorkManager.postData(endpoint: endpoint, parameters: user, responseType: UserResponse.self)
            
            switch response {
            case .success(result: let user):
                return user
                
            case .failure(error: let error):
                throw error
            }
        } catch {
            throw error
        }
    }
    
    
    func getProduct(endpoint: String) async throws -> [Product] {
        do {
            let response =  try await netWorkManager.getData(endpoint: endpoint, parameters: nil, responseType: ProductArray.self)
            
            switch response {
            case .success(result: let product):
                return product.products
                
            case .failure(error: let error):
                throw error
            }
        } catch {
            throw error
        }
    }
}
