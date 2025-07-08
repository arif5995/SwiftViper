////
////  MainRouter.swift
////  SwiftViper
////
////  Created by Muhammad Arif on 30/06/25.
////
//
//import Foundation
//import SwiftUICore
//
//class AppRouter: ObservableObject, AuthRouterProtocol {
//    func createModule(authManager: AuthenticationManager) {
//        <#code#>
//    }
//    
//    
//    @Published var isUserLoggedIn: Bool = false // State utama untuk navigasi
//    
//    func navigateToHome() {
//        DispatchQueue.main.async{
//            self.isUserLoggedIn = true
//            print("isUserLoggedIn di AppRouter diubah menjadi: \(self.isUserLoggedIn)")
//        }
//    }
//    
//    func navigateToLogin() {
//        DispatchQueue.main.async{
//            self.isUserLoggedIn = false
//            print("isUserLoggedIn di AppRouter diubah menjadi: \(self.isUserLoggedIn)")
//        }
//    }
//}
//
//struct ModulFactory {
//    
//    static func modulHomePresenter() -> HomePresenter {
//        let networkManager = NetWorkManager()
//        let repository = ProductRepository(netWorkManager: networkManager)
//        let interactor = HomeInteractor(productRepository: repository)
//        let presenter = HomePresenter(homeInteractor: interactor)
//        
//        return presenter
//    }
//    
//    static func moduleAuthPresenter() -> AuthPresenter {
////        let router = AppRouter()
//        let networkManager = NetWorkManager()
//        let repository = ProductRepository(netWorkManager: networkManager)
//        let interactor = AuthInteractor(productRepository: repository)
//        let presenter = AuthPresenter(loginInteractor: interactor, router: AppRouter())
//        
//        return presenter
//    }
//    
////    static func createModuleHome() -> NavigationBarView {
////        
////        let view = NavigationBarView(productPresenter: modulHomePresenter(), profilePresenter: moduleAuthPresenter())
////        return view
////    }
////    
////    static func createnModuleLogin() -> LoginView {
////
////        let view = LoginView(loginPresenter: moduleAuthPresenter())
////        return view
////    }
//}

class AppRouter {

    static func createAuthModule(authManager: AuthenticationManager) -> LoginView {
        return AuthRouter.createModule(authManager: authManager)
    }
    
    static func createProfileModule(authManager: AuthenticationManager) -> ProfileView {
        return ProfileRouter.createModulProfile(authManager: authManager)
    }

    
    static func createHomeModule() -> ProductHomeView {
        return HomeRouter.createHomeModule()
    }
}
