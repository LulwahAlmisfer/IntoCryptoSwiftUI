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
                            CoinImageView(coin: coin).frame(width: 50, height: 50)
                            Text(coin.name).foregroundColor(.theme.background).font(.title2).bold()
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                                    .bold()
                                Text((coin.currentHoldings ?? 0).asNumberString())
                            }.foregroundColor(.theme.background)
                            VStack{
                               
                                Text(coin.currentPrice.asCurrencyWith6Decimals())
                                    .bold()
                                    .foregroundColor(Color.theme.background)
                                Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                                    .foregroundColor(
                                        (coin.priceChangePercentage24H ?? 0 >= 0) ?
                                        Color.theme.green :
                                        Color.theme.red
                                    )
                            }
                           
                            
                                .padding(.vertical)

                        
                        }.padding(.horizontal,35)
                      
                       // ChartView(coin: coin).frame(width: 150, height: 1)
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
            Text(coin.currentPrice.asCurrencyWith6Decimals())
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
