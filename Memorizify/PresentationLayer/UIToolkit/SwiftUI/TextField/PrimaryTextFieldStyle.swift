//
//  PrimaryTextFieldStyle.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import SwiftUI

struct PrimaryTextFieldStyle: TextFieldStyle {
    
    let title: String
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading) {
            Text(title.uppercased())
                .font(.caption)
                .opacity(0.45)
            configuration
            Divider()
        }
    }
}

#Preview {
    @State var value = "Text field"
    
    return VStack {
        TextField("", text: $value)
            .textFieldStyle(PrimaryTextFieldStyle(title: "some title"))
            .padding()
    }
}
