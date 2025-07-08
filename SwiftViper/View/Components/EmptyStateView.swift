//
//  EmptyStateView.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 04/06/25.
//

import Foundation
import SwiftUI

struct EmptyStateView: View {
   
    let viewModel: EmptyStateUIModel
   
    init(viewModel: EmptyStateUIModel) {
       self.viewModel = viewModel
   }
   
    var body: some View {
       ZStack(alignment: .center) {
           VStack(spacing: 0) {
               
               Image(systemName: viewModel.image)
                   .font(.system(size: 90))
               
               Text(viewModel.title)
                   .foregroundStyle(Color.black)
                   .frame(maxWidth: .infinity,alignment: .center)
                   .padding(.top, 12)
               
               Text(viewModel.message)
                   .foregroundStyle(Color.black)
                   .frame(maxWidth: .infinity,alignment: .center)
                   .padding(.top, 4)
           }
           .padding(.horizontal, 16)
           .padding(.vertical, 16)
       }
   }
}
