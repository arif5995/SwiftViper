//
//  HomeRouter.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 07/07/25.
//

import Foundation

class HomeRouter: HomeRouterProtocol {
    static func createHomeModule() -> ProductHomeView {
        let interactor = HomeInteractor(productRepository: ProductRepository(netWorkManager: NetWorkManager()))
        let router = HomeRouter()
        let presenter = HomePresenter(interactor: interactor, router: router)
        
        return ProductHomeView(homePresenter: presenter)
    }
    
    
}
