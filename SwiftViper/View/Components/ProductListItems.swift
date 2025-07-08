//
//  ProductListItems.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 04/06/25.
//

import SwiftUI

struct ProductListItems: View {
    @State var product: Product = .mock
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            
            imageView
            
            titleView
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cornerRadius(16)

    }
}

private extension ProductListItems {
    
    @ViewBuilder
    var imageView: some View {
        if let url = URL(string: product.firstImage) {
            CachedAsyncImage(url: url)
                .frame(width: imageSize.width, height: imageSize.height)
        }
    }
    
    @ViewBuilder
    var titleView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(product.title)
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundStyle(Color.black)
            
            Text(product.description)
                .font(.system(size: 12))
                .lineLimit(2)
                .foregroundStyle(Color.black)
        }
        
    }
    
    var imageSize: CGSize {
        return .init(width: 80, height: 80)
    }
}

#Preview {
    ZStack {
        ProductListItems()
    }
}
