//
//  ForgotPasswordView.swift
//  SwiftfulCrypto
//
//  Created by lulwah on 18/01/2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
   @StateObject private var viewModel = ForgotPasswordViewModelImpl(
      service: ForgotPasswordServiceImpl())
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack(spacing: 16) {
            
                InputTextFieldView(text:$viewModel.email,
                                   placeholder: "Email",
                                   keyboardType: .emailAddress,
                                   systemImage: "envelope")
                .font(.title3)
                .background(Color.theme.accent.opacity(0.05))
                .foregroundColor(Color.secondary)
                .padding(2)
                .frame(maxWidth: .infinity)
                .cornerRadius(50)
               .shadow(color: Color.primary.opacity(0.05), radius: 60, x: 0.0, y: 16)
                
                ButtonView(title: "Send Password Reset") {
                    viewModel.sendPasswordResetRequest()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle("Reset Password")
        .applyClose()
        }
}
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
