//
//  CoinRowView.swift
//  SwiftfulCrypto
//
//  Created by Nick Sarno on 5/8/21.
//

import SwiftUI

struct CoinRowView: View {
        
    let coin: CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        
        HStack(spacing: 0) {
            if showHoldingsColumn {

                
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 25).foregroundColor(.theme.accent).frame(width: 350, height: 200)
                    
        VStack {
                        
                        HStack{
                            VStack{
                                HStack{
                                    CoinImageView(coin: coin).frame(width: 33, height: 33)
                                    
                                    Text(coin.name).foregroundColor(.theme.background).font(.title2).bold()}.padding(.top,30)
                                
                        VStack(alignment: .leading) {
                            Text("$" + coin.currentHoldingsValue
                                .asNumberString()
                               // .asCurrencyWith2Decimals()
                            ).bold()
                               
                            
                            
                            Text((coin.currentHoldings ?? 0)
                              // .asCurrencyWith2Decimals()
                                .asNumberString()// + "$"
                            )
                                .bold()
                            
                        }.foregroundColor(.theme.background)
                            }
                            Spacer()
                        
                            
                            
                            VStack(alignment: .trailing){
                              
                                Text("$" + coin.currentPrice
                                    .asNumberString()
                                  // .asCurrencyWith6Decimals()
                                    
                                )
                                    .bold()
                                    .padding(.top,10)
                                    .foregroundColor(Color.theme.background)
                                
                                
                                Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                                    .foregroundColor(
                                        (coin.priceChangePercentage24H ?? 0 >= 0) ?
                                        Color.theme.green :
                                        Color.theme.red
                                    )
                                
                                

                            }.padding(.trailing,10)
                           
                            
                             
                        
                        }.padding(.horizontal,35)
                      
                        ChartView(coin: coin)
                            .padding(.bottom,35).aspectRatio(contentMode: .fit)
                     
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
         
            
        } else
            {
            leftColumn
            Spacer()
            if showHoldingsColumn {
                
                centerColumn
            }
            rightColumn
        }
        }
        .font(.subheadline)
        .background(
            Color.theme.background.opacity(0.001)
        )
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingsColumn: false)
                .previewLayout(.sizeThatFits)

            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}

extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accent)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text("$" +
                coin.currentPrice
                .asNumberString()
                //.asCurrencyWith6Decimals()
            )
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0 >= 0) ?
                    Color.theme.green :
                    Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
