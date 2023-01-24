//
//  Profile.swift
//  SwiftfulCrypto
//
//  Created by Han on 15/01/2023.
//


import SwiftUI

struct Profile: View {
    
    @State private var Toggling = false
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
     var name : String
    @EnvironmentObject var service: SessionServiceImpl
    
    var body: some View {
        NavigationView{
            //VStack Containing all items
            VStack{
                //VStack for the Profile Image and Name
                Button(action: Helper.goToAppSetting) {
                 HStack {
                     Image(systemName: "globe")
                         .resizable()
                         .frame(width: 25, height: 25)
                         .foregroundColor(Color("SecondMainColor"))
                     Spacer()
                 }
                 .padding(.horizontal,30)
                }
                VStack{
                    
                    
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100,alignment: .center)
                        .padding(.top,30)
                        .foregroundColor(Color("SecondMainColor"))
                    
                    
                    Text(name).font(Font.title3.weight(.semibold)).frame(height: 40,alignment: .center)
                }
                //-----------------------------------------------------------//
                //ZStack with calling class SettingsList
                
          
                    
                    List {
                        
                           
                            NavigationLink(destination: Account(), label: {
                                Text("Account")
                            }).foregroundColor(Color("MainColor"))
                                .listRowBackground(Color("SecondMainColor"))
                            
             
                            
                            //Leave a review
                            Link(destination: URL(string: "https://www.apple.com/sa/app-store/")!){
                                
                                HStack{
                                    
                                    
                                    Text("Terms and Conditions")
                                    Spacer()
                                    Image(systemName: "link")
                                    
                                    
                                }
                            }.foregroundColor(Color("MainColor"))
                                .listRowBackground(Color("SecondMainColor"))
                            
                            //Terms and conditions
                            
                            Link(destination: URL(string: "https://www.apple.com/sa/app-store/")!){
                                
                                HStack{
                                    
                                    
                                    Text("Leave a Review")
                                    Spacer()
                                    Image(systemName: "link")
                                    
                                    
                                }
                                
                            }.foregroundColor(Color("MainColor"))
                                .listRowBackground(Color("SecondMainColor"))
                            
                         
                                
                         
                            //Dark Mode
                       
                                
                                HStack{
                               
                                    
                                    Toggle("Dark Mode",isOn: $isDarkMode)
                                         .foregroundColor(Color("MainColor"))
                                               
            
                                
                            }.foregroundColor(Color("MainColor"))
                                .listRowBackground(Color("SecondMainColor"))
                            
                            
                       
                        
                    }.scrollDisabled(true)
                     .background(Color("MainColor"))
                     .scrollContentBackground(.hidden)
                    
                    
                    
                    
                    //ZStack with calling class SettingsList
                    VStack{
                        Button("Logout", action: {
                          //  print("عدلوه")
                            service.logout()
                        }).padding(.bottom,35)
                            .foregroundColor(.red)
                            .bold()
                        
                        Text("Contact us").font(.system(size: 15)).fontWeight(.semibold)
                        
                        ContactUS()
                    }.aspectRatio(contentMode: .fit).padding(.bottom,100)
                    
                    
                    
                }.background(Color("MainColor"))
                
            }
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
        Profile(name: "leen")
    }
}
