//
//  ProfileRouter.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 07/07/25.
//

import Foundation

protocol ProfileRouterProtocol: Any {
    static func createModulProfile(authManager: AuthenticationManager) -> ProfileView
}

class ProfileRouter: ProfileRouterProtocol {
    static func createModulProfile(authManager: AuthenticationManager)->ProfileView{
        let interactor = AuthInteractor(productRepository: ProductRepository(netWorkManager: NetWorkManager()))
        _ = AuthRouter()
        let presenter = AuthPresenter(loginInteractor: interactor, authManager: authManager)
        
        return ProfileView(profilePresenter: presenter)
    }
}
