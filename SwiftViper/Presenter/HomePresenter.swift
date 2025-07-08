//
//  ProductPresenter.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 03/06/25.
//

import Foundation

class HomePresenter: ObservableObject, HomePresenterProtocol, HomeInteractorOutputProtocol {
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var listProduct: [Product] = []
    
    private var interactor: HomeInteractorInputProtocol
    private var router: HomeRouter
    
    init(interactor: HomeInteractorInputProtocol, router: HomeRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        isLoading = true
        interactor.fetchProductList { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self.listProduct = products.data ?? []
                    self.isLoading = false
                case .failure(let error):
                    print(error)
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
    func fetchProductSuccess(products: [Product]) {
        isLoading = false
        interactor.presenter?.fetchProductSuccess(products: products)
    }
    
    func fetchProductFailed(error: String) {
        isLoading = false
        interactor.presenter?.fetchProductFailed(error: error)
    }
    
    func noExistingProductFound() {
        print("Data empty")
    }
    

    
}
