//
//  changelanguage.swift
//  SwiftfulCrypto
//
//  Created by Lulwah Almisfer on 22/01/2023.
//

import SwiftUI
import Foundation
struct changelanguage: View {
    
    var body: some View {
    
        Button(action: Helper.goToAppSetting) {
            VStack {
                Image(systemName: "globe")
                    .resizable()
                    .frame(width: 40, height: 40,alignment: .center)
                   .padding(.top,150)
                    .foregroundColor(Color("SecondMainColor"))
            }
        }

       
    }
}

struct changelanguage_Previews: PreviewProvider {
    static var previews: some View {
        changelanguage()
        
    }
}

