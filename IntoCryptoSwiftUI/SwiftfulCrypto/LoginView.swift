//
//  LoginView.swift
//  SwiftfulCrypto
//
//  Created by lulwah on 18/01/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var showRegistration = false
    @State private var showForgotPassword = false
    @StateObject private var viewModel = LoginViewModelImpl(
        service: LoginServiceImpl()
    )
    

    var body: some View {
        
        VStack(spacing: 16) {
            Spacer()
            Text("Log In")
                .font(.system(size: 50, weight: .bold))
                .foregroundColor(Color("SecondMainColor"))
                .padding()
            VStack {
                //email and password
                InputTextFieldView(text:  $viewModel.credentials.email,
                                   placeholder: "Email",
                                   keyboardType: .emailAddress,
                                   systemImage: "envelope")
                .font(.title3)
                .background(Color.theme.accent.opacity(0.05))
                .foregroundColor(Color.secondary)
                .padding(2)
                .frame(maxWidth: .infinity)
                .cornerRadius(50)
                .shadow(color: Color.accentColor.opacity(0.05), radius: 60, x: 0.0, y: 16)
               // .padding(.vertical)
                
                InputPasswordView(password: $viewModel.credentials.password,
                                  placeholder: "Password",
                                  systemImage: "lock")
                .font(.title3)
                .background(Color.theme.accent.opacity(0.05))
                .foregroundColor(Color.secondary)
                .padding(2)
                .frame(maxWidth: .infinity)
                .cornerRadius(50)
                .shadow(color: Color.accentColor.opacity(0.05), radius: 60, x: 0.0, y: 16)
                            }
            .padding(.vertical)

            VStack {
                //Spacer()
                Button(action: {
                    showForgotPassword.toggle()
                }, label: {
                    Text("Forgot Password?")
                })
                .font(.system(size: 16, weight: .semibold))
                .sheet(isPresented: $showForgotPassword) {
                        ForgotPasswordView()
                }
            }
            
            VStack(spacing: 16) {
                
                ButtonView(title: "Login") {
                    viewModel.login()
                    
                }
                
                ButtonView(title: "Register",
                           background: .clear,
                           foreground: .primary,
                           border: .primary) {
                    showRegistration.toggle()
                }
                           
                .sheet(isPresented: $showRegistration) {
                        RegisterView()
                }
            }
            Spacer()
            
        }
        .padding(.horizontal, 15)
        //.navigationTitle("Login")
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct ButtonView: View {
   
   typealias ActionHandler = () -> Void
   
   let title: String
   let background: Color
   let foreground: Color
   let border: Color
   let handler: ActionHandler
   
   private let cornerRadius: CGFloat = 10
   
   internal init(title: String,
                 background: Color = .theme.accent,
                 foreground: Color = .theme.background,
                 border: Color = .clear,
                 handler: @escaping ButtonView.ActionHandler) {
       self.title = title
       self.background = background
       self.foreground = foreground
       self.border = border
       self.handler = handler
   }
   
   var body: some View {
       
       Button(action: {
           handler()
       }, label: {
           Text(title)
               .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 50)
       })
       .padding(5)
       .background(background)
       .foregroundColor(foreground)
       .font(.system(size: 16, weight: .bold))
       .cornerRadius(40)
       .overlay(
           RoundedRectangle(cornerRadius: 40)
               .stroke(border, lineWidth: 2)
               
       )
   }
}


/**
* Textfield input view component
*/

struct InputTextFieldView: View {
   
   @Binding var text: String
   let placeholder: String
   let keyboardType: UIKeyboardType
   let systemImage: String?
   
   private let textFieldLeading: CGFloat = 30
   
   var body: some View {
       
       VStack {
           //email textfield
           TextField(placeholder, text: $text)
               .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                      minHeight: 44,
                      alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
               .padding(.leading, systemImage == nil ? textFieldLeading / 2 : textFieldLeading)
               .keyboardType(keyboardType)
               .background(Color.theme.accent.opacity(0.200))
              
               .background(
                   //image email
                   ZStack(alignment: .leading) {
                       
                       if let systemImage = systemImage {
                           
                           Image(systemName: systemImage)
                               .font(.system(size: 16, weight: .semibold))
                               .padding(.leading, 5)
                               
                       }
                           
                       RoundedRectangle(cornerRadius: 40,
                                        style: .continuous)
                           .stroke(Color.accentColor.opacity(0.05), lineWidth: 2)
                           
                   }
               )
       }
   }
}

struct InputPasswordView: View {
   
   @Binding var password: String
   let placeholder: String
   let systemImage: String?
    
   
   private let textFieldLeading: CGFloat = 30
   
   var body: some View {
       
       VStack {
           //password textfield
           SecureField(placeholder, text: $password)
               .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                      minHeight: 44,
                      alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
               .padding(.leading, systemImage == nil ? textFieldLeading / 2 : textFieldLeading)
               .background(Color.theme.accent.opacity(0.200))
               .background(
                   
                   ZStack(alignment: .leading) {
                       
                       if let systemImage = systemImage {
                           
                           Image(systemName: systemImage)
                               .font(.system(size: 16, weight: .semibold))
                               .padding(.leading, 5)
                               //.foregroundColor(Color.accentColor.opacity(0.5))
                       }
                       
                       RoundedRectangle(cornerRadius: 10,
                                        style: .continuous)
                           .stroke(Color.accentColor.opacity(0.25), lineWidth: 1)
                   }
               )
       }
   }
}
