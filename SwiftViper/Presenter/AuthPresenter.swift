//
//  LoginPresenter.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 30/06/25.
//

import Foundation

class AuthPresenter: ObservableObject, AuthPresenterProtocol,
    AuthInteractorOutputProtocol
{
    @Published var isLoading: Bool = false
    @Published var currentUser: UserResponse? = UserResponse.mock
    @Published var errorMessage: String? = nil

    private var loginInteractor: AuthInteractorInputProtocol
    private var authManager: AuthenticationManager

    init(
        loginInteractor: AuthInteractorInputProtocol,
        authManager: AuthenticationManager
    ) {
        self.loginInteractor = loginInteractor
        self.authManager = authManager
        self.loginInteractor.presenter = self

    }

    func checkAuth() {
        self.loginInteractor.checkExistingAuth()
        //        let token = UserDefaults.standard.value(forKey: "token")
        //
        //        if (token == nil) {
        //            self.router.navigateToHome()
        //        } else {
        //            self.router.navigateToLogin()
        //        }

    }

    func loginButtonTapped(userParam: UserParam) {
        isLoading = true
        loginInteractor.signInUser(user: userParam) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userResponse):
                    print(userResponse)
                    self.currentUser = userResponse.data
                    print(
                        "email: \(String(describing: self.currentUser?.email))")
                    self.isLoading = false
                case .failure(let error):
                    print(error)
                    self.isLoading = false
                }
            }
        }
    }

    func getCurrentUser() {
        isLoading = true
        if let data = UserDefaults.standard.data(forKey: "currentUser") {
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(UserResponse.self, from: data)
                currentUser = user
                isLoading = false
                print("User data loaded successfully!")
            } catch {
                print("Error decoding user data: \(error.localizedDescription)")
            }
        }
    }

    func logOut() {
        loginInteractor.logOut()
    }

    func authSucceeded(response: UserResponse) {
        isLoading = false
        authManager.authenticate(response: response)
    }

    func authFailed(error: any Error) {
        isLoading = false
        errorMessage = error.localizedDescription
    }

    func existingAuthFound(user: UserResponse) {
        isLoading = false
        authManager.authenticate(response: user)
    }

    func noExistingAuthFound() {
        // isLoading = false
    }

    func logOutSuccess(isLogout: Bool) {
        isLoading = false
        authManager.logout()
    }

}
