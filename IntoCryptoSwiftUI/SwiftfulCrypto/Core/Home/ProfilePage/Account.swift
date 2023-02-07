
import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseCore
import FirebaseAuth

struct Account: View {
    @EnvironmentObject var service: SessionServiceImpl
    @Environment(\.managedObjectContext) var moc
    @State var ref: DatabaseReference!
    var name : String
    
    let AccountSettings = [
        
        "Email: Leen99@hotmail.com"
    ]
    
    @AppStorage("User_Email") private var email = ""
    
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                //VStack for the Profile Image and Name
                    Button(action: Helper.goToAppSetting) {
                        HStack {
                            Image(systemName: "globe")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(.top,20)
                                .foregroundColor(Color("SecondMainColor"))
                            Spacer()
                        }
                        .padding(.horizontal,30)
                        
                    }
                    //VStack for the Profile Image and Name
                    
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
                    
                    ZStack{
                        
                        NavigationView{
                            List{
                                
                                ForEach(self.AccountSettings, id: \.self)
                                {
                        //two texts for localization reasons
             item in Text("Email: ") + Text(" \(email)")
                                    
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
                            
                            
              Auth.auth().currentUser!.delete { error in
                                if let error = error {
                                    print("error deleting user - \(error)")
                                } else {
                                    print("Account deleted")
                                }
                            }
                            
                            
                        }).padding(.bottom,100)
                            .foregroundColor(.red)
                            .bold()
                        
                        
                    }.padding(.bottom,100)
                    
                    
                    
                }.background(Color("MainColor"))
                
            }
            
        }
        
        
    }
    
    
    
    
    struct Account_Previews: PreviewProvider {
        static var previews: some View {
            Account(name: "Leen")
        }
    }
    
}
