//
//  SignUpCompletedView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import SwiftUI

struct SignUpCompletedView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            VStack {
                Text("Success!")
                    .foregroundStyle(.green)
                    .bold()
                    .padding()
                Text("Please verify your email address and then log in!")
                    .multilineTextAlignment(.center)
            }
            .padding()
            Button("Back") {
                router.clearPath()
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SignUpCompletedView()
}
