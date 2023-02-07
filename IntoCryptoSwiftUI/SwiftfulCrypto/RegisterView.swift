
import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegistrationViewModelImpl(
        service: RegistrationServiceImpl())
        
    var body: some View {
        
        NavigationView {
          
            ZStack {
         
               Color.theme.background.ignoresSafeArea()
                Button(action: Helper.goToAppSetting) {
                    VStack {
                        Image(systemName: "globe")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.top,1)
                            .foregroundColor(Color("SecondMainColor"))
                        Spacer()
                    }
                    .padding(.trailing,300)
                    
                }
                VStack(spacing: 32) {
               
                    VStack(spacing: 16) {
                        
                        Text("Register")
                            .font(.system(size: 50, weight: .bold))
                            .padding()
                            .foregroundColor(Color("SecondMainColor"))
                        InputTextFieldView(text: $viewModel.newUser.email,
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
                        InputPasswordView(password: $viewModel.newUser.password,
                                          placeholder: "Password",
                                          systemImage: "lock")
                        .font(.title3)
                        .background(Color.theme.accent.opacity(0.05))
                        .foregroundColor(Color.secondary)
                        .padding(2)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(50)
                       .shadow(color: Color.primary.opacity(0.05), radius: 60, x: 0.0, y: 16)
                
                        InputTextFieldView(text: $viewModel.newUser.Name,
                                           placeholder: LocalizedStringKey("Name"),
                                           keyboardType: .namePhonePad,
                                           systemImage: nil)
                        .font(.title3)
                        .background(Color.black.opacity(0.05))
                        .padding(2)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.05), radius: 60, x: 0.0, y: 16)
                       
                        
                    
                    }
                    Button(LocalizedStringKey("Sign up")){
            
                        viewModel.create()
                    }  .frame(maxWidth: .infinity, maxHeight: 65,alignment: .center)
                        .background(Color("SecondMainColor"))
                            .foregroundColor(Color("MainColor"))
                            .cornerRadius(40)
                            .font(.system(size: 20) .bold())
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color("MainColor"), lineWidth: 2)
                                    
                            )
                }
                .padding(.horizontal, 15)
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

