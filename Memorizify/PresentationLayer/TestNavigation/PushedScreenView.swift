//
//  PushedScreenView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.03.2024.
//

import SwiftUI

struct PushedScreenView: View {
    
    let someString: String
    
    var body: some View {
        Text(someString)
    }
}

#Preview {
    PushedScreenView(someString: "Hello there!")
}
