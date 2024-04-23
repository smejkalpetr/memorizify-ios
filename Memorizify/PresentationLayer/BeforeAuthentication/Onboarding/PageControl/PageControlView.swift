//
//  PageControlView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 21.04.2024.
//

import SwiftUI

struct PageControlView: View {
    
    let numberOfPages: Int
    
    @Binding var currentPage: Int
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfPages) { page in
                Rectangle()
                    .fill(page == currentPage ? Color("primary_color") : Color.gray)
                    .frame(width: 25, height: 6)
                    .padding(.horizontal, 1)
            }
        }
    }
}

#Preview {
    PageControlView(
        numberOfPages: 0,
        currentPage: Binding<Int>(get: { return 0 }, set: { _, _ in }))
}
