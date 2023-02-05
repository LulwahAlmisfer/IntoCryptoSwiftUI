//
//  BuySellCoinsView.swift
//  SwiftfulCrypto
//
//  Created by Azzam AL-Rashed on 05/02/2023.
//

import SwiftUI

struct BuySellCoinsView: View {
    
    @Binding var coin: CoinModel?
    @State var method = 1
    @State var amount = "2"
    
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
                        
                        HStack{
                            Text("Amount")
                            TextField("", text: $amount).textFieldStyle(.roundedBorder)
                        }.padding()
                        
                        HStack{
                            Text("Market price:")
                            Text("\(coin.currentPrice.asNumberString())")
                            Text("Total")
                            Text("\((coin.currentPrice * (Double(amount) ?? 0)).asNumberString())")
                        }.padding()
                        Spacer()
                        ButtonView(title: method == 1 ? "Buy": "Sell"){
                            print("d")
                        }
                    }
                }.padding()
                    .padding(.vertical,30)
            }
        }
        
    }}
    struct BuySellCoinsView2: PreviewProvider {
        static var previews: some View {
            BuySellCoinsView(coin: .constant(dev.coin))
            
        }
    }
    
    

