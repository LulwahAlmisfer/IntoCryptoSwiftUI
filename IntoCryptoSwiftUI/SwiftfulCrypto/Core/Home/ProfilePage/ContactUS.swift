
import SwiftUI
import MessageUI
struct ContactUS: View {
    var body: some View {
        VStack{
            HStack{
             
                Link(destination: URL(string: "https://twitter.com/IntoCryptoApp")!) {
                    
                    Image("TwitterIcon").resizable().frame(width: 32,height: 32,alignment: .trailing).clipShape(Circle())
                }
                
                Link(destination: URL(string: "https://www.instagram.com/intocryptoapp/")!) {
                    Image("InstagramIcon").resizable().frame(width: 32,height: 32).clipShape(Circle())
                }
                
                Link(destination: URL(string:"mailto:intocryptoapp@outlook.com")!) {
                    Image("MailIcon").resizable().frame(width: 32,height: 32).clipShape(Circle())
                    
                }
                
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ContactUS_Previews: PreviewProvider {
    static var previews: some View {
        ContactUS()
    }
}
