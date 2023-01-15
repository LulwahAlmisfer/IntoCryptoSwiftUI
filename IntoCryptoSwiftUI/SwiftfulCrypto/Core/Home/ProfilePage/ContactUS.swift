//
//  ContactUS.swift
//  SwiftfulCrypto
//
//  Created by Han on 15/01/2023.
//

import SwiftUI

struct ContactUS: View {
    var body: some View {
        VStack{
            HStack{
             
                
                Image("TwitterIcon").resizable().frame(width: 32,height: 32,alignment: .trailing).clipShape(Circle())
                
                Image("TelegramIcon").resizable().frame(width: 32,height: 32).clipShape(Circle())
                
                Image("MailIcon").resizable().frame(width: 32,height: 32).clipShape(Circle())
                
                
                
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ContactUS_Previews: PreviewProvider {
    static var previews: some View {
        ContactUS()
    }
}
