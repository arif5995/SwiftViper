//
//  NetworkManager.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 03/06/25.
//

import Foundation
import UIKit

struct APIService {
    func requestService<T:Decodable>(urlRequest: URLRequest, resultType: T.Type, completionHandler: @escaping (_ result: T?,_ error: Error?) -> Void)  {
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(T.self, from: data)
                        completionHandler(jsonData, nil)
                    } catch let err {
                        print(err)
                        completionHandler(nil, err)
                    }
                }
            }else {
                completionHandler(nil, error)
            }
        }
    }
}

// MARK: - API ResponseHandler
typealias APIResponseHandler<T: Decodable> = ((ResponseHandler<T>) -> Void)
enum ResponseHandler<T: Decodable> {
    case success(result: T)
    case failure(error: Error)
}

// MARK: - NetworkManager

protocol NetWorkManagerProtocol {
    func request<T: Decodable>(
        endpoint: String,
        parameters: Encodable?,
        responseType: T.Type) async throws -> ResponseHandler<T>
    
    func postData<T: Decodable>(
        endpoint: String,
        parameters: Encodable,
        responseType: T.Type) async throws -> ResponseHandler<T>
    
    func getData<T: Decodable>(
        endpoint: String,
        parameters: Encodable?,
        responseType: T.Type) async throws -> ResponseHandler<T>
}

final class NetWorkManager: NetWorkManagerProtocol {
    
//    private var apiService: APIService
//    
//    
//    init(_apiService: APIService) {
//        apiService = _apiService
//    }

    //    fileprivate func checkNetworkConnection() throws {
    //        guard Reachability.isConnectedToNetwork() else {
    //            throw FailureResponse.noInternet
    //        }
    //    }
    
    func postData<T: Decodable>(
        endpoint: String,
        parameters: Encodable,
        responseType: T.Type
    )async throws -> ResponseHandler<T> {
        
        _ = URLSession(configuration: .default)
        
        try await Reachability().checkInternet()
        
        guard let urlComponents = URLComponents.init(string: endpoint) else {
            return .failure(error: FailureResponse.invalidURL)
            
        }
        
        guard let url = urlComponents.url else {
            return .failure(error: FailureResponse.invalidURL)
        }
        
        /// Create a URLRequest for the POST request.
        var urlRequest = URLRequest(url: url)
        
        /// Configure the HTTP method.
        urlRequest.httpMethod = "POST"
 
        /// Configure the proper content-type value to JSON.
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        /// Define the struct of data and encode it to data.
        let jsonData = try JSONEncoder().encode(parameters)
        
        print(jsonData)
        
        /// Pass in the data as the HTTP body.
        urlRequest.httpBody = jsonData

        /// Use URLSession to fetch the data asynchronously.
        let (data, httpResponse) = try await URLSession.shared.data(for: urlRequest)
        
        print((httpResponse as? HTTPURLResponse)?.statusCode ?? 0)
        print(ResponseCode.success.rawValue)
        print(String(data: data, encoding: .utf8) ?? "")
        
        print((httpResponse as? HTTPURLResponse)!.statusCode == ResponseCode.success.rawValue)
        
        guard (httpResponse as? HTTPURLResponse)?.statusCode == ResponseCode.success.rawValue else {
            return .failure(error: FailureResponse.invalidResponse)
        }
        
        do {
            let response = try JSONDecoder().decode(responseType.self, from: data)
            print(data)
            print(response)
            return .success(result: response)
        } catch {
            print("Terjadi error tak terduga: \(error.localizedDescription)")
            return .failure(error: FailureResponse.invalidResponse)
        }
    
    }
    
    
    func getData<T: Decodable>(
        endpoint: String,
        parameters: Encodable?,
        responseType: T.Type
    )async throws -> ResponseHandler<T> {
        
        _ = URLSession(configuration: .default)
        
        try await Reachability().checkInternet()
        
        guard let urlComponents = URLComponents.init(string: endpoint) else {
            return .failure(error: FailureResponse.invalidURL)
            
        }
        
        guard let url = urlComponents.url else {
            return .failure(error: FailureResponse.invalidURL)
        }
        
        /// Create a URLRequest for the POST request.
        var urlRequest = URLRequest(url: url)
        
        /// Configure the HTTP method.
        urlRequest.httpMethod = "GET"
 
        /// Configure the proper content-type value to JSON.
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let parameters {
            /// Define the struct of data and encode it to data.
            let jsonData = try JSONEncoder().encode(parameters)
            
            /// Pass in the data as the HTTP body.
            urlRequest.httpBody = jsonData
        }

        /// Use URLSession to fetch the data asynchronously.
        let (data, httpResponse) = try await URLSession.shared.data(for: urlRequest)
        
        guard (httpResponse as? HTTPURLResponse)?.statusCode == ResponseCode.success.rawValue else {
            return .failure(error: FailureResponse.invalidResponse)
        }
        
        do {
            let response = try JSONDecoder().decode(responseType.self, from: data)
            return .success(result: response)
        } catch {
            return .failure(error: FailureResponse.invalidResponse)
        }
    
    }
    

    
    func request<T: Decodable>(
        endpoint: String,
        parameters: Encodable?,
        responseType: T.Type) async throws -> ResponseHandler<T> {
            
            let session = URLSession(configuration: .default)
            
            try await Reachability().checkInternet()
            
            guard let urlComponents = URLComponents.init(string: endpoint) else {
                return .failure(error: FailureResponse.invalidURL)
                
            }
            
            
            guard let url = urlComponents.url else {
                return .failure(error: FailureResponse.invalidURL)
            }
            
            let (data, httpResponse) = try await session.data(from: url)
            
            guard (httpResponse as? HTTPURLResponse)?.statusCode == ResponseCode.success.rawValue else {
                return .failure(error: FailureResponse.invalidResponse)
            }
            
            do {
                let response = try JSONDecoder().decode(responseType.self, from: data)
                return .success(result: response)
            } catch {
                return .failure(error: FailureResponse.invalidResponse)
            }
            
        }
    
}
