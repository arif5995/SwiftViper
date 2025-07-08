//
//  ProductPresenter.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 03/06/25.
//

import Foundation

class HomePresenter: ObservableObject, HomePresenterProtocol, HomeInteractorOutputProtocol {
    
    @Published var errorMessage: String = ""
    @Published var listProduct: [Product] = []
    
    private var interactor: HomeInteractorInputProtocol
    private var router: HomeRouter
    
    init(interactor: HomeInteractorInputProtocol, router: HomeRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.fetchProductList { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self.listProduct = products.data ?? []
                case .failure(let error):
                    print(error)
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchProductSuccess(products: [Product]) {
        interactor.presenter?.fetchProductSuccess(products: products)
    }
    
    func fetchProductFailed(error: String) {
        interactor.presenter?.fetchProductFailed(error: error)
    }
    
    func noExistingProductFound() {
        print("Data empty")
    }
    

    
}
