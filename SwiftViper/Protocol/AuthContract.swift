//
//  LoginContract.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 30/06/25.
//

import Foundation

struct APIResponse<T> {
    let data: T?
    let statusCode: Int
    let errorMessage: String?
}

enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

// MARK: - Login Protocols
protocol AuthViewProtocol: AnyObject { // View akan punya referensi lemah ke Presenter
    func displayLoginError(message: String)
}

protocol AuthPresenterProtocol: ObservableObject {
    func loginButtonTapped(userParam: UserParam)
    func getCurrentUser()
    func checkAuth()
    func logOut()
    var currentUser: UserResponse? { get set}
}

protocol AuthInteractorInputProtocol: AnyObject {
    var presenter: AuthInteractorOutputProtocol? { get set }
    func signInUser(user: UserParam, completion: @escaping (Result<APIResponse<UserResponse>, Error>) -> Void)
    func logOut()
    func checkExistingAuth()
}

protocol AuthInteractorOutputProtocol: AnyObject {
    func authSucceeded(response: UserResponse)
    func authFailed(error: Error)
    func existingAuthFound(user: UserResponse)
    func noExistingAuthFound()
    func logOutSuccess(isLogout: Bool)
}

protocol AuthRouterProtocol: AnyObject {
    static func createModule(authManager: AuthenticationManager)->LoginView
}
