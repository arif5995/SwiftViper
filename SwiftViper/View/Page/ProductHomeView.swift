//
//  ProductDetailsView.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 03/06/25.
//

import SwiftUI

struct ProductHomeView: View {
    @StateObject var homePresenter: HomePresenter
    
    var body: some View {
        NavigationStack {
            VStack {
                if homePresenter.listProduct.isEmpty && !homePresenter.isLoading {
                    emptyStateView
                } else {
                    List (homePresenter.listProduct){ product in
                        prepareListItem(product: product)
                            .padding(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12))
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Product")
            .toolbarVisibility(.visible)
            .onAppear {
                homePresenter.viewDidLoad()
            }
            .refreshable {
                homePresenter.viewDidLoad()
            }
        }
        .overlay {
            if (homePresenter.isLoading) {
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
    
    private var emptyStateView: some View {
        EmptyStateView(
            viewModel: .init(
                image: "wifi.exclamationmark.circle.fill",
                title: "Something wrong!",
                message: ErrorMessage.emptyState.rawValue,
                size: .init(
                    width: 72,
                    height: 72
                )
            )
        )
    }
    
    func prepareListItem(product: Product) -> some View {
        ProductListItems(product: product)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        
    }
}

#Preview {
//    ProductHomeView()
    ProductHomeView(homePresenter: HomePresenter(interactor: HomeInteractor(productRepository: ProductRepository(netWorkManager: NetWorkManager())), router: HomeRouter()))
}
