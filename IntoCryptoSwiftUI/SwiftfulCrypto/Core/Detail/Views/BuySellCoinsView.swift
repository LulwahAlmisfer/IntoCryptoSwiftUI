
import SwiftUI

struct BuySellCoinsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var coin: CoinModel?
    @State var method = 1
    @State var amount = ""
    @State var oldamount = "0"
    @Binding  var showBuySellView: Bool
    @State var showingAlert = false
    @State var showingAlert2 = false
    @AppStorage("WalletCredit") var WalletCredit : Double = 100000
    @State var OldWalletCredit: Double = 0.0
    @AppStorage("total") var total : Double = 0.0
    
    
    var body: some View {
        NavigationView{
            VStack{
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
                            
                            
                            HStack{
                                
                                Text("Balance: \(WalletCredit, specifier: "%.0f")").bold().italic()
                                
                                
                            }.foregroundColor(.gray)
                            
                            HStack{
                                Text("Amount:").font(.title3).fontWeight(.semibold)
                                TextField("Enter Amount", text: $amount).textFieldStyle(.roundedBorder)
                            }.padding(2).foregroundColor(.theme.accent)
                            
                            
                            
                            VStack{
                                HStack(alignment: .center){
                                    Text("Market price:").fontWeight(.semibold)
                                    Text("$\(coin.currentPrice.asNumberString())")
                                }.padding()
                                
                                
                                
                                HStack{
                                    
                                    Text("Your Total:").fontWeight(.semibold)
                                    Text("\(( coin.currentPrice * (Double(amount) ?? 0)).asNumberString())")
                                    
                                }
                                
                                if method == 2 {
                                    
                                    HStack {
                                        Text("Holdings Amount:").foregroundColor(.theme.accent).fontWeight(.semibold)
                                        Text(oldamount).foregroundColor(.theme.accent)
                                    }.padding()
                                }
                            }.padding().foregroundColor(.theme.accent).font(.title3)
                            Spacer()
                            Button(LocalizedStringKey("Reset Balance"), action: {
                                WalletCredit = 100000.0
                                
                            }).foregroundColor(.red).bold().italic()
                            Button(method == 1 ? LocalizedStringKey("Buy"): LocalizedStringKey("Sell")){
                                if method == 1 {
                                    
                                    if let oldamountD = Double(oldamount) {
                                        
                                        vm.updatePortfolio(coin: coin, amount: oldamountD + Double(amount)!)
                                        
                                        
                                        total = Double(amount)! * coin.currentPrice
                                        
                                        WalletCredit = ( WalletCredit - (Double(amount)! * coin.currentPrice))
                                        
                                        if WalletCredit - total < 0.0{
                                            WalletCredit = WalletCredit + total
                                            showingAlert2.toggle()
                                            showBuySellView.toggle()
                                        }
                                        
                                    }else{
                                        vm.updatePortfolio(coin: coin, amount:  Double(amount)!)
                                        
                                        
                                    }
                                    
                                } else {
                                    if oldamount < amount {
                                        showingAlert.toggle()
                                        showBuySellView.toggle()
                                        
                                    }else {
                                        vm.updatePortfolio(coin: coin, amount:( Double(oldamount)! - Double(amount)!))
                                        
                                        WalletCredit = (WalletCredit + (coin.currentPrice * Double(amount)!))
                                        
                                        
                                    }
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
            }.onAppear{
                
                updateSelectedCoin2(coin: coin!)
                
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text("You can't sell!"), message: Text("Reset balance or Buy"), dismissButton: .default(Text("Got it!")))}
        }.navigationBarTitle("", displayMode: .inline).onAppear{
            
            updateSelectedCoin2(coin: coin!)
            
        }.alert(isPresented: $showingAlert2) {
            Alert(title: Text("You can't buy!"), message: Text("Reset balance or Sell"), dismissButton: .default(Text("Got it!")))}
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
    
    

