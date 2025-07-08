//
//  Reachability.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 03/06/25.
//

import Foundation
import Network

class Reachability {
  let monitor = NWPathMonitor()
  let queue = DispatchQueue.global(qos: .background)
  

    func checkInternet() async throws {
        return try await withCheckedThrowingContinuation { continuation in
            let monitor = NWPathMonitor()
            let queue = DispatchQueue(label: "Monitor")
            
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    print("Connected to network")
                    continuation.resume()
                } else {
                    print("No network connection")
                    continuation.resume(throwing: NetworkCheckError.noConnection)
                }
                monitor.cancel()
            }
            
            monitor.start(queue: queue)
        }
    }
    
//    func isConnectedToNetwork() -> Bool {
//        monitor.pathUpdateHandler = { path in
//            if path.status == .satisfied {
//                print("Connected to network")
//            } else {
//                print("No network connection")
//            }
//
//            if path.usesInterfaceType(.wifi) {
//                print("Using WiFi")
//            } else if path.usesInterfaceType(.cellular) {
//                print("Using Cellular")
//            }
//        }
//    }
}
