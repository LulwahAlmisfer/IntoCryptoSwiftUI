

import SwiftUI

struct OnBoarding1View: View {
    @Binding var shouldshowonb :Bool
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    var body: some View {
     
        ZStack{
        
            Color.theme.background.ignoresSafeArea()
            VStack {
               
                
                HStack{
                    Button(action: Helper.goToAppSetting) {
                        HStack {
                            Image(systemName: "globe")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color("SecondMainColor"))
                        }
                        HStack(alignment: .center){
                                Button(action: {
                                isDarkMode.toggle()
                                    
                                }, label: {
                                    Image(systemName: isDarkMode ? "moon.circle.fill" : "cloud.sun.circle")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(Color("SecondMainColor"))
                                }
                                       
                                )}.preferredColorScheme(isDarkMode ? .dark : .light)
                    }
                 
                        
                    
                    Spacer()
                    Text("Skip").underline().onTapGesture {
                        shouldshowonb.toggle()
                    }
                }.padding(.horizontal)
                LottieView(filename: "99448-crypto-coins")
                VStack{
                    Text("Sensation of true trading").font(.title).bold().foregroundColor(.theme.accent)
                    Text("Get a representation of the market")
                    Text("and monitor your wallet").foregroundColor(.theme.accent)
                }
                .padding(.bottom,100)
            }.foregroundColor(.theme.accent).font(.title3)
                
        }
    }
}

struct OnBoarding1View_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding1View(shouldshowonb: .constant(true))
    }
}
