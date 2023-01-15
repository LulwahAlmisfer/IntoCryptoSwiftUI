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
                    Spacer()
                    Text("Skip").underline().onTapGesture {
                        shouldshowonb.toggle()
                    }
                }.padding(.horizontal)
                LottieView(filename: "99448-crypto-coins")
                Text("Sensation of true trading").font(.title2).bold()
                Text("Get a representation of the market ")
                Text("and monitor your wallet  ").foregroundColor(.black)
            }.foregroundColor(.theme.accent).font(.title2)
        }
    }
}

struct OnBoarding1View_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding1View(shouldshowonb: .constant(true))
    }
}
