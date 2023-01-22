//
//  OnBoarding1View.swift
//  SwiftfulCrypto
//
//  Created by lulwah on 14/01/2023.
//

import SwiftUI

struct OnBoarding1View: View {
    @Binding var shouldshowonb :Bool
    var body: some View {
     
        ZStack{
            Color.theme.background.ignoresSafeArea()
            VStack {
                HStack{
                    Button(action: Helper.goToAppSetting) {
                        HStack {
                            Image(systemName: "globe")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color("SecondMainColor"))
                        }   
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
