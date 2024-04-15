//
//  ResetPasswordCompletedView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import SwiftUI

struct ResetPasswordCompletedView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            Text("If there is an account associated with the provided email, a link will be sent to the email which will contain instruction on how to reset the password.")
                .multilineTextAlignment(.center)
                .bold()
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
    ResetPasswordCompletedView()
}
