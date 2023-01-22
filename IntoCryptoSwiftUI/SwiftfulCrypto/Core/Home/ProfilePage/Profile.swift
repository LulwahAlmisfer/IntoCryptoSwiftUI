//
//  Profile.swift
//  SwiftfulCrypto
//
//  Created by Han on 15/01/2023.
//

import SwiftUI
import Foundation

struct Profile: View {
    
    @EnvironmentObject var service: SessionServiceImpl
   // @EnvironmentObject private var vm: HomeViewModel
    @State var selector = 1
   // @State private var showRegistration = false
    //@State private var showDetailView: Bool = false
    var body: some View {
     
    
        //VStack Containing all items
         VStack{
             Button(action: Helper.goToAppSetting) {
                 HStack {
                     Image(systemName: "globe")
                         .resizable()
                         .frame(width: 30, height: 30)
                         .foregroundColor(Color("SecondMainColor"))
                     Spacer()
                 }
                 .padding(.horizontal)
             }
       //VStack for the Profile Image and Name
             
             VStack{

                 Image(systemName: "person.crop.circle.fill")
                     .resizable()
                     .frame(width: 100, height: 100,alignment: .center)
                     .padding(.top,30)
                     .foregroundColor(Color("SecondMainColor"))
                 
            
               // Text(" \(service.userDetails?.Name ?? "temp")" )
                     //.font(Font.title3.weight(.semibold)).frame(height: 40,alignment: .center)
                 
                // Text("Leen").font(Font.title3.weight(.semibold)).frame(height: 40,alignment: .center)
             }
             //-----------------------------------------------------------//
      //ZStack with calling class SettingsList
             
             ZStack{
                 SettingsList()
             }
              
          
             //ZStack with calling class SettingsList
             VStack{
                 ButtonView(title: "Log Out" ,
                            background: .clear,
                            foreground: .red) {
                     service.logout()
                 }
                     

                 Text("Contact us").font(.system(size: 15)).fontWeight(.semibold)
             
                 ContactUS()
             }.aspectRatio(contentMode: .fit).padding(.bottom,100)
             
        

         }.background(Color("MainColor"))
        
       
    }
    
      
         }
struct Helper {
    static func goToAppSetting() {
        DispatchQueue.main.async {
            if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
                UIApplication.shared.open(appSettings)
            }
        }
    }
}


struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
