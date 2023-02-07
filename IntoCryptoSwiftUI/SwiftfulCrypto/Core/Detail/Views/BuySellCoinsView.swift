
import SwiftUI

struct BuySellCoinsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var coin: CoinModel?
    @State var method = 1
    @State var amount = ""
    @State var oldamount = "0"
    @Binding  var showBuySellView: Bool
    @State var showingAlert = false
    var body: some View {
        NavigationView{
            ZStack {
                Color.theme.background.ignoresSafeArea()
                VStack (spacing:25){
                    if let coin = coin {
                        HStack {
                            
                            CoinImageView(coin: coin).frame(width: 40, height: 40)
                            
                            Text(coin.name).foregroundColor(.theme.accent).fontWeight(.semibold).font(.system(size: 20))
                        
                            
                        }
                        Picker(selection: $method, label: Text("Picker")) {
                            Text("Buy").tag(1)
                            Text("Sell").tag(2)
                        
                        }.pickerStyle(.segmented).frame(width: 330,alignment: .center)
                            .padding()
     
                        
                        
                        HStack{
                            Text("Amount:").font(.title3).fontWeight(.semibold)
                            TextField("Enter Amount", text: $amount).textFieldStyle(.roundedBorder)
                        }.padding(30).foregroundColor(.theme.accent)
                        
                        
            
                        VStack{
                            HStack(alignment: .center){
                                Text("Market price:").fontWeight(.semibold)
                                Text("\(coin.currentPrice.asNumberString())")
                            }.padding()

                  
                            HStack(alignment: .center){
                                Text("Your Total:").fontWeight(.semibold)
                                Text("\((coin.currentPrice * (Double(amount) ?? 0)).asNumberString())")
                            }
                            
                            if method == 2 {
                                
                                HStack {
                                    Text("Holdings Amount:").foregroundColor(.theme.accent).fontWeight(.semibold)
                                    Text(oldamount).foregroundColor(.theme.accent)
                                }.padding()
                            }
                        }.padding().foregroundColor(.theme.accent).font(.title3)
                        Spacer()
                    
                        Button(method == 1 ? LocalizedStringKey("Buy"): LocalizedStringKey("Sell")){
                            if method == 1 {
                                
                                if let oldamountD = Double(oldamount) {
                                    vm.updatePortfolio(coin: coin, amount: oldamountD + Double(amount)!)
                                } else {
                                    vm.updatePortfolio(coin: coin, amount:  Double(amount)!)
                                }
                               
                            } else {
                                if oldamount == "0.0"{
                                    showingAlert.toggle()
                                    showBuySellView.toggle()
                                } else {
                                    vm.updatePortfolio(coin: coin, amount:( Double(oldamount)! - Double(amount)!))}
                            }
                     
                             
    showBuySellView.toggle()
                            
}.frame(maxWidth: .infinity, maxHeight: 65,alignment: .center)
                            .background(Color("SecondMainColor"))
                                .foregroundColor(Color("MainColor"))
                                .cornerRadius(40)
                                .font(.system(size: 20) .bold())                                .overlay(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color("MainColor"), lineWidth: 2)
                                        
                                )
                    }
                }.padding()
                    .padding(.vertical,30)
            }
        }  .navigationBarTitle("", displayMode: .inline)
     
            .onAppear{
            
            updateSelectedCoin2(coin: coin!)
            
        }
        .alert(isPresented: $showingAlert) {
                    Alert(title: Text("You can't sell!"), message: Text("Buy need to buy first"), dismissButton: .default(Text("Got it!")))
                }
        
        }
        
    private func updateSelectedCoin2(coin: CoinModel) {
      
        
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount2 = portfolioCoin.currentHoldings {
            oldamount = "\(amount2)"
        } else {
            oldamount = "0.0"
        }
    }
    }


    struct BuySellCoinsView2: PreviewProvider {
        static var previews: some View {
            BuySellCoinsView(coin: .constant(dev.coin), showBuySellView: .constant(true) ).environmentObject(dev.homeVM)
            
        }
    }
    
    

