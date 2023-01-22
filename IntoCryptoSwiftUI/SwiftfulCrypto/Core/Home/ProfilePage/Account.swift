//
//  Account.swift
//  Learning
//
//  Created by Han on 18/01/2023.
//

import SwiftUI

struct Account: View {
    
    let AccountSettings = [
        
        "Email: Leen99@hotmail.com"
    ]
    
    var body: some View {
        NavigationView{
            VStack{
                
                //VStack for the Profile Image and Name
                
                VStack{
                    
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100,alignment: .center)
                        .padding(.top,30)
                        .foregroundColor(Color("SecondMainColor"))
                    
                    Text("Leen").font(Font.title3.weight(.semibold)).frame(height: 40,alignment: .center)
                }
                //-----------------------------------------------------------//
                //ZStack with calling class SettingsList
                
                ZStack{
                    
                    NavigationView{
                        List{
                            
                            ForEach(self.AccountSettings, id: \.self)
                            {
                                item in Text(item)
                                
                            } .foregroundColor(Color("MainColor"))
                                .listRowBackground(Color("SecondMainColor"))
                        }
                        .background(Color("MainColor"))
                        .scrollContentBackground(.hidden)
                        
                        
                        
                        
                    }.padding(.all,10)
                        .scrollDisabled(true)
                }
                
                
                //ZStack with calling class SettingsList
                VStack{
                    Button("Delete Account", action: {
                        print("عدلوه")
                    }).padding(.bottom,100)
                        .foregroundColor(.red)
                        .bold()
                    
                    
                }.aspectRatio(contentMode: .fit).padding(.bottom,100)
                
                
                
            }  
        }
  
                                      }
                                }
        
    

    
    struct Account_Previews: PreviewProvider {
        static var previews: some View {
            Account()
        }
    }

