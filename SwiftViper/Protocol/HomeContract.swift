//
//  HomeContract.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 03/07/25.
//

import Foundation


// MARK: - Home Protocols
protocol HomeViewProtocol: AnyObject {
    func displayWelcomeMessage(user: String)
}

protocol HomePresenterProtocol: ObservableObject {
    var listProduct: [Product] { get }
    var errorMessage: String {get set}
    func viewDidLoad()
}

protocol HomeInteractorInputProtocol: AnyObject {
    var presenter: HomeInteractorOutputProtocol? {get set}
    func fetchProductList(completion: @escaping (Result<APIResponse<[Product]>, Error>) -> Void)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func fetchProductSuccess(products: [Product])
    func fetchProductFailed(error: String)
    func noExistingProductFound()
}
  

protocol HomeRouterProtocol: AnyObject {
    static func createHomeModule() -> ProductHomeView
}
