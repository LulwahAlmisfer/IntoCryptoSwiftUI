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
                    Text("Register")
                        .font(.system(size: 55, weight: .bold))
                        .padding()
                        .foregroundColor(Color("SecondMainColor"))
                    InputTextFieldView(text: $viewModel.newUser.email,
                                       placeholder: "Email",
                                       keyboardType: .emailAddress,
                                       systemImage: "envelope")
                    .font(.title3)
                    .background(Color.black.opacity(0.05))
                    .padding(2)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(50)
                    .shadow(color: Color.black.opacity(0.05), radius: 60, x: 0.0, y: 16)
                    InputPasswordView(password: $viewModel.newUser.password,
                                      placeholder: "Password",
                                      systemImage: "lock")
                    .font(.title3)
                    .background(Color.black.opacity(0.05))
                    .padding(2)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(50)
                    .shadow(color: Color.black.opacity(0.05), radius: 60, x: 0.0, y: 16)
                   // Divider()
                    InputTextFieldView(text: $viewModel.newUser.Name,
                                       placeholder: "Name",
                                       keyboardType: .namePhonePad,
                                       systemImage: nil)
                    .font(.title3)
                    .background(Color.black.opacity(0.05))
                    .padding(2)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(50)
                    .shadow(color: Color.black.opacity(0.05), radius: 60, x: 0.0, y: 16)
                   
                    
                
                }
                
                ButtonView(title: "Sign up") {
                    viewModel.create()
                }
            }
            .padding(.horizontal, 15)
            //.navigationTitle("Register")
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

