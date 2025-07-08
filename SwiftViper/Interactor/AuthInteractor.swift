//
//  LoginInteractor.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 30/06/25.
//

import Foundation


final class AuthInteractor: AuthInteractorInputProtocol {

    let productRepository: ProductRepositoryProtocol
    weak var presenter: AuthInteractorOutputProtocol?

    init(productRepository: ProductRepositoryProtocol) {
        self.productRepository = productRepository
    }
    
    func signInUser(user: UserParam, completion: @escaping (Result<APIResponse<UserResponse>, any Error>) -> Void) {
        Task {
            do {
                let response = try await productRepository.signIn(endpoint: "https://dummyjson.com/auth/login", user: user)
                UserDefaults.standard.set(response.accessToken, forKey: "token")
                completion(.success(APIResponse(data: response, statusCode: 200, errorMessage: nil)))
                print(response)
                self.presenter?.authSucceeded(response: response)
            }catch{
                completion(.failure(error))
                self.presenter?.authFailed(error: error)
            }
        }
    }
    
    func logOut() {
        UserDefaults.standard.removeObject(forKey: "token")
        self.presenter?.logOutSuccess(isLogout: true)
    }
    
    func checkExistingAuth() {
        if let userData = UserDefaults.standard.data(forKey: "currentUser"),
           let user = try? JSONDecoder().decode(UserResponse.self, from: userData){
            self.presenter?.existingAuthFound(user: user)
        } else {
            self.presenter?.noExistingAuthFound()
        }
    }

}
