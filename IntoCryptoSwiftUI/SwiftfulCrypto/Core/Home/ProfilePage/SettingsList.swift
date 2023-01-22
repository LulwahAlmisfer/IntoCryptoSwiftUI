//
//  SettingsList.swift
//  SwiftfulCrypto
//
//  Created by Han on 15/01/2023.
//

import SwiftUI

struct SettingsList: View {
    
    let Settings = [
     "Account",
     "Terms and Conditions",
     "Leave a Review",
     "Change Language",
     "Dark Mode"
     ]
     
     var body: some View {
     
     
     
     
     NavigationView{
     List{
     
     ForEach(self.Settings, id: \.self)
     {
     item in Text(item)
     
     } .foregroundColor(Color("MainColor"))
     .listRowBackground(Color("SecondMainColor"))
     }
     .background(Color("MainColor"))
     .scrollContentBackground(.hidden)
     
     
     
     
     
     }.navigationTitle("Settings").padding(.all,10)
     .scrollDisabled(true)
     }
    
}

struct SettingsList_Previews: PreviewProvider {
    static var previews: some View {
        SettingsList()
    }
}
