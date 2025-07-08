//
//  ContentView.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 03/06/25.
//

import SwiftUI

struct ContentView: View {
    // Inisiasi AppRouter sekali untuk seluruh aplikasi
    @StateObject var authManager: AuthenticationManager = AuthenticationManager()
    var body: some View {
        NavigationStack {
            if authManager.isAuthenticated {
                NavigationBarView()
                    .environmentObject(authManager)
            } else {
                AppRouter.createAuthModule(authManager: authManager)
                
            }
        }
    }
}

#Preview {
    ContentView()
}
