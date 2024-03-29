
import SwiftUI

struct LoginView: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @State private var showRegistration = false
    @State private var showForgotPassword = false
    @StateObject private var viewModel = LoginViewModelImpl(
        service: LoginServiceImpl()
    )
    @AppStorage("key18")  var shouldshowonb = true

    var body: some View {
        //change language icon
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack(spacing: 16) {
                HStack(spacing: 270){
                    Button(action: Helper.goToAppSetting) {
                          
                                Image(systemName: "globe")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color("SecondMainColor"))
                            }
                     
                        Button(action: {
                            isDarkMode.toggle()
                            
                        }, label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "cloud.sun.circle")
                                .resizable()
                                .frame(width: 25, height: 25,alignment: .top)
                                .foregroundColor(Color("SecondMainColor"))
                        }
                               
                        ).preferredColorScheme(isDarkMode ? .dark : .light)
                    
                }
                
                Spacer()
                
                
                //Login Title
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
                   .shadow(color: Color.primary.opacity(0.05), radius: 60, x: 0.0, y: 16)
                    
                    InputPasswordView(password: $viewModel.credentials.password,
                                      placeholder: "Password",
                                      systemImage: "lock")
                    .font(.title3)
                    .background(Color.theme.accent.opacity(0.05))
                    .foregroundColor(Color.secondary)
                    .padding(2)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(50)
                    .shadow(color: Color.primary.opacity(0.05), radius: 60, x: 0.0, y: 16)
                                }
                .padding(.vertical)

                
                //forget password button -> goes to the forget password page
                VStack {
                  
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
                //Login Button to sign the user after checking the info entered
                VStack(spacing: 16){
                    Button(LocalizedStringKey("Login")){
                      
                        viewModel.login()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 65,alignment: .center)
                    .background(Color("SecondMainColor"))
                        .foregroundColor(Color("MainColor"))
                        .cornerRadius(40)
                        .font(.system(size: 20) .bold())
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color("MainColor"), lineWidth: 2)
                        )
                     
                    //-------------------------------//
        
        //register button that'll go to the register and sign up the user
         //register checks if the email is used in the database or not before signning up the user
                    
                    Button(LocalizedStringKey("Register") ){

                        showRegistration.toggle()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 60,alignment: .center)
                        .background(.clear)
                            .foregroundColor(Color("SecondMainColor"))
                            .cornerRadius(40)
                            .font(.system(size: 20) .bold())
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color("SecondMainColor"), lineWidth: 2)
                                    
                            ).sheet(isPresented: $showRegistration) {
                            RegisterView()
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 15)
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
        .fullScreenCover(isPresented: $shouldshowonb ){
           tab(shouldshowonb: $shouldshowonb)
        }
        
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct ButtonLocalizedStringKey: View {
   
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
                 handler: @escaping ButtonLocalizedStringKey.ActionHandler) {
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



struct InputTextFieldView: View {
   
   @Binding var text: String
   let placeholder: LocalizedStringKey
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
               .background(Color.theme.secondaryText.opacity(0.3))
              
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
   let placeholder: LocalizedStringKey
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
               .background(Color.theme.secondaryText.opacity(0.3))
               .background(
                   
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
