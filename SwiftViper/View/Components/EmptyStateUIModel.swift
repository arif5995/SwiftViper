//
//  EmptyStateUIModel.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 04/06/25.
//

import Foundation

struct EmptyStateUIModel {
    init(
        image: String,
        title: String,
        message: String,
        size: CGSize = .init(width: 200, height: 200)
    ) {
        self.image = image
        self.title = title
        self.message = message
        self.size = size
    }
    
    let image: String
    let title: String
    let message: String
    let size: CGSize
}
