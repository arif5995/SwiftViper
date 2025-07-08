//
//  NavigationBarView.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 04/07/25.
//

import SwiftUI

struct NavigationBarView: View {
    @State private var selectedTab: Int = 0
    @EnvironmentObject var authManager: AuthenticationManager

    var body: some View {
        TabView(selection: $selectedTab) {
            AppRouter.createHomeModule()
                .tabItem {
                    Text("Home")
                }
                .tag(0)

            AppRouter.createProfileModule(authManager: authManager)
                .tabItem {
                    Text("Profile")
                }
                .tag(1)
        }
    }
}

#Preview {
    NavigationBarView()
}
