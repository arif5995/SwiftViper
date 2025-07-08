//
//  LoginView.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 04/06/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginPresenter: AuthPresenter
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Login New App")
                    .font(.largeTitle)
                    .padding([.top, .bottom], 40)
                
                Image(systemName: "globe.europe.africa.fill")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .padding(.bottom, 50)
                    .foregroundStyle(.gray)
                
                TextField("Email", text: $username)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(10)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(10)
                
                Button(action: {
                    // Aksi: Menampilkan pesan di konsol
                    print("Tombol Text ditekan!")
                    loginPresenter.loginButtonTapped(
                        userParam: UserParam(
                            username: "emilys", password: "emilyspass"))
                }) {
                    // Label: Teks "Tekan Saya"
                    Text("Login")
                        .padding()  // Menambah jarak di dalam tombol
                        .background(Color.blue)  // Mengatur warna latar belakang
                        .foregroundColor(.white)  // Mengatur warna teks
                        .cornerRadius(10)  // Memberikan sudut membulat
                }
            }
            .foregroundStyle(.black)
            .padding([.leading, .trailing], 27.5)
        }
        .overlay {
            if (loginPresenter.isLoading) {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
                    ProgressView("Mohon Tunggu...")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
            
        }

    }
}

#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        //        LoginView()
        LoginView(
            loginPresenter: AuthPresenter(
                loginInteractor: AuthInteractor(
                    productRepository: ProductRepository(
                        netWorkManager: NetWorkManager())),
                authManager: AuthenticationManager()))
    }
}
