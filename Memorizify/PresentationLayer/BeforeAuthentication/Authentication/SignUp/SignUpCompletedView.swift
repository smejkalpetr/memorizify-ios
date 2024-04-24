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
                Text("Please, check your inbox and verify the address using a link which was sent to your email!")
                    .multilineTextAlignment(.center)
            }
            .padding()
            Button("Back") {
                router.clearAllPaths()
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
