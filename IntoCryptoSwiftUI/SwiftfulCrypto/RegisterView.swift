//
//  RegisterView.swift
//  SwiftfulCrypto
//
//  Created by lulwah on 18/01/2023.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegistrationViewModelImpl(
        service: RegistrationServiceImpl())
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 32) {
                
                VStack(spacing: 16) {
                    
                    InputTextFieldView(text: $viewModel.newUser.email,
                                       placeholder: "Email",
                                       keyboardType: .emailAddress,
                                       systemImage: "envelope")
                    
                    InputPasswordView(password: $viewModel.newUser.password,
                                      placeholder: "Password",
                                      systemImage: "lock")
                    
                    Divider()
                    
                    InputTextFieldView(text: $viewModel.newUser.Name,
                                       placeholder: "Name",
                                       keyboardType: .namePhonePad,
                                       systemImage: nil)
                    
                   
                    
                
                }
                
                ButtonView(title: "Sign up") {
                    viewModel.create()
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle("Register")
            .applyClose()
            .alert(isPresented: $viewModel.hasError,
                   content: {
                    
                    if case .failed(let error) = viewModel.state {
                        return Alert(
                            title: Text("Error"),
                            message: Text(error.localizedDescription))
                    } else {
                        return Alert(
                            title: Text("Error"),
                            message: Text("Something went wrong"))
                    }
             })
     
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

struct NavigationCloseViewModifier: ViewModifier {
    
    @Environment(\.presentationMode) var presentationMode
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
            }
    }
}

extension View {
    
    func applyClose() -> some View {
        self.modifier(NavigationCloseViewModifier())
    }
}

