//
//  AuthRouter.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 07/07/25.
//

import Foundation


class AuthRouter: AuthRouterProtocol {
    static func createModule(authManager: AuthenticationManager)->LoginView{
        let interactor = AuthInteractor(productRepository: ProductRepository(netWorkManager: NetWorkManager()))
        _ = AuthRouter()
        let presenter = AuthPresenter(loginInteractor: interactor, authManager: authManager)
        
        return LoginView(loginPresenter: presenter)
    }
    
    
    
}
