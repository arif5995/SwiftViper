//
//  ProductInteractor.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 03/06/25.
//

import Foundation


final class HomeInteractor: HomeInteractorInputProtocol {
    weak var presenter: (any HomeInteractorOutputProtocol)?
    
    let productRepository: ProductRepositoryProtocol

    init(productRepository: ProductRepositoryProtocol) {
        self.productRepository = productRepository
    }
    
    func fetchProductList(completion: @escaping (Result<APIResponse<[Product]>, any Error>) -> Void) {
        Task {
            do {
                let response = try await productRepository.getProduct(endpoint: "https://dummyjson.com/products")
                completion(.success(APIResponse(data: response, statusCode: 200, errorMessage: nil)))
                presenter?.fetchProductSuccess(products: response)
            }catch{
                completion(.failure(error))
                presenter?.fetchProductFailed(error: error.localizedDescription)
            }
        }
    }

}
