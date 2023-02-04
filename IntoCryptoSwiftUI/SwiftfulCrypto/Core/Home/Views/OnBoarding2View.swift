
import SwiftUI

struct OnBoarding2View: View {
    @Binding var shouldshowonb :Bool
    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
            VStack {
        
                LottieView(filename: "105300-crypto")
                Text("Ideal Learning").font(.title).bold()
                Text("register an account")
                Text("and start virtually trading")
                Text("with real-time prices risk free")
                
                Button {
                    shouldshowonb.toggle()
                } label: {
                    ZStack {
                        Rectangle().frame(width: 350, height: 55)
                        Text("Start Now").foregroundColor(.theme.background)
                    }
               
                }

            }.foregroundColor(.theme.accent).font(.title2)
        }
    }
}

struct OnBoarding2View_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding2View(shouldshowonb: .constant(true))
    }
}
