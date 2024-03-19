//
//  PrimaryTextFieldStyle.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import SwiftUI

struct PrimaryTextFieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding(10)
                .background(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [Color.orange, Color.yellow]
                        ),
                        startPoint: .topLeading, 
                        endPoint: .bottomTrailing
                    )
                    .opacity(0.7)
                )
                .cornerRadius(5)
                .shadow(color: .gray, radius: 4)
        }
}

#Preview {
    @State var value = "Text field"
    
    return VStack {
        TextField("Placeholder", text: $value)
            .textFieldStyle(PrimaryTextFieldStyle())
            .padding()
    }
}
