//
//  Profile.swift
//  SwiftfulCrypto
//
//  Created by Han on 15/01/2023.
//

import SwiftUI

struct Profile: View {
    @State var selector = 1
    var body: some View {
        //VStack Containing all items
         VStack{
             
       //VStack for the Profile Image and Name
             
             VStack{

                 Image(systemName: "person.crop.circle.fill")
                     .resizable().frame(width: 100, height: 100).padding()
            
                 Text("Leen")
             }
             
      //ZStack with calling class SettingsList
             
             ZStack{
                 SettingsList()
             }
              
          
             //ZStack with calling class SettingsList
             VStack{
                 
                 Text("Contact us").font(.system(size: 15)).fontWeight(.semibold)
             
                 ContactUS()
             }.aspectRatio(contentMode: .fit)
             

      
             

         }

     }
      
         }
   

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
