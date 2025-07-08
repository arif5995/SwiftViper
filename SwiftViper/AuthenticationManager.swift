//
//  AuthenticationManager.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 07/07/25.
//

import Foundation

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated: Bool {
        didSet {
            UserDefaults.standard.set(isAuthenticated, forKey: "isAuthenticated")
        }
    }
    
    @Published var authToken: String? {
        didSet {
            if let token = authToken {
                UserDefaults.standard.set(token, forKey: "authToken")
            } else {
                UserDefaults.standard.removeObject(forKey: "authToken")
            }
        }
    }
    
    @Published var currentUser: UserResponse? {
        didSet {
            if let user = currentUser,
               let encodeUser = try? JSONEncoder().encode(user){
                UserDefaults.standard.set(encodeUser, forKey: "currentUser")
            } else {
                UserDefaults.standard.removeObject(forKey: "currentUser")
            }
        }
    }
    
    init() {
        self.isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")
        self.authToken = UserDefaults.standard.string(forKey: "authToken")
    }
    
    func authenticate(response: UserResponse){
        DispatchQueue.main.async {
            self.currentUser = response
            self.authToken = response.accessToken
            self.isAuthenticated = true
        }
    }
    
    func logout() {
        self.authToken = nil
        self.isAuthenticated = false
    }
    
}
