//
//  BuySellCoinsView.swift
//  SwiftfulCrypto
//
//  Created by Azzam AL-Rashed on 05/02/2023.
//

import SwiftUI

struct BuySellCoinsView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var coin: CoinModel?
    @State var method = 1
    @State var amount = ""
    @State var oldamount = "0"
    var body: some View {
        NavigationView{
            ZStack {
                Color.theme.background.ignoresSafeArea()
                VStack (spacing:30){
                    if let coin = coin {
                        HStack {
                            Text(coin.name).foregroundColor(.theme.accent)
                            
                            CoinImageView(coin: coin).frame(width: 50, height: 50)
                            
                        }
                        
                        Spacer()
                        Picker(selection: $method, label: Text("Picker")) {
                            Text("buy").tag(1)
                            Text("sell").tag(2)
                        }.pickerStyle(.segmented)
                        
                        if method == 2 {
                            
                            HStack {
                                Text("Owned = ").foregroundColor(.theme.accent)
                                Text(oldamount).foregroundColor(.theme.accent)
                            }
                        }
                        HStack{
                            Text("Amount")
                            TextField("enter amount", text: $amount).textFieldStyle(.roundedBorder)
                        }.padding()
                        
                        HStack{
                            Text("Market price:")
                            Text("\(coin.currentPrice.asNumberString())")
                            Text("Total")
                            Text("\((coin.currentPrice * (Double(amount) ?? 0)).asNumberString())")
                        }.padding()
                        Spacer()
                    
                ButtonLocalizedStringKey(title: method == 1 ? "Buy": "Sell"){
                    if method == 1 {
                        vm.updatePortfolio(coin: coin, amount:( Double(oldamount)! + Double(amount)!))
                    } else {
                        vm.updatePortfolio(coin: coin, amount:( Double(oldamount)! - Double(amount)!))
                    }
                        }
                    }
                }.padding()
                    .padding(.vertical,30)
            }
        }.onAppear{
            
            updateSelectedCoin2(coin: coin!)
            
        }
        }
        
    private func updateSelectedCoin2(coin: CoinModel) {
      
        
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount2 = portfolioCoin.currentHoldings {
            oldamount = "\(amount2)"
        } else {
            oldamount = ""
        }
    }
    }


    struct BuySellCoinsView2: PreviewProvider {
        static var previews: some View {
            BuySellCoinsView(coin: .constant(dev.coin))  .environmentObject(dev.homeVM)
            
        }
    }
    
    

