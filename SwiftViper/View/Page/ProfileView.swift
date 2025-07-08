//
//  ProfileView.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 04/07/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var profile: UserResponse = .mock
    @StateObject var profilePresenter: AuthPresenter

    var body: some View {
        VStack {
            
            if let url = URL(string: profilePresenter.currentUser?.image ?? profile.image) {
                CachedAsyncImage(url: url)
                    .scaledToFill()  // Mengisi lingkaran tanpa distorsi
                    .frame(width: 150, height: 150)  // Ukuran gambar
                    .clipShape(Circle())  // Membuat gambar menjadi lingkaran
                    .overlay(Circle().stroke(Color.blue, lineWidth: 2))  // Garis tepi lingkaran
                    .shadow(radius: 10)  // Efek bayangan
            }
            
            if let firstName = profilePresenter.currentUser?.firstName,
               let lastName = profilePresenter.currentUser?.lastName{
                // MARK: - Nama Lengkap
                Text("\(firstName) \(lastName)")
                    .font(.title)  // Ukuran font judul
                    .fontWeight(.bold)  // Tebal
                    .foregroundColor(.primary)
            }
            
            if let username = profilePresenter.currentUser?.username {
                // MARK: - Username
                Text("@\(username)")
                    .font(.headline)  // Ukuran font sub-judul
                    .foregroundColor(.secondary)  // Warna teks sekunder (lebih redup)
            }


            if let email = profilePresenter.currentUser?.email {
                // MARK: - Email
                Text(email)
                    .font(.subheadline)  // Ukuran font sub-judul yang lebih kecil
                    .foregroundColor(.secondary)
                    .padding(.top, 5)  // Sedikit padding di atas email
            }


            // MARK: - Tombol atau Aksi Lainnya (Opsional)
            Spacer()  // Mendorong konten ke atas

            Button(action: {
                // Aksi saat tombol "Logout" ditekan
                print("Logout ditekan!")
                profilePresenter.logOut()
            }) {
                Text("Logout")
                    .font(.headline)
                    .foregroundColor(.red) // Warna merah untuk menandakan aksi penting
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.1)) // Latar belakang merah muda transparan
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .padding()  // Padding keseluruhan untuk VStack
        .navigationTitle("Profil Pengguna")  // Judul di NavigationBar
        .navigationBarTitleDisplayMode(.inline)  // Menempatkan judul di tengah
        .onAppear {
            profilePresenter.getCurrentUser()
        }
        
    }
}

#Preview {
    ProfileView(profilePresenter: AuthPresenter(loginInteractor: AuthInteractor(productRepository: ProductRepository(netWorkManager: NetWorkManager())), authManager: AuthenticationManager()))
}
