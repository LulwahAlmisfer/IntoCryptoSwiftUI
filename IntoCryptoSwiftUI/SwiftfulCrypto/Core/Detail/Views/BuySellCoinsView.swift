//
//  BuySellCoinsView.swift
//  SwiftfulCrypto
//
//  Created by Azzam AL-Rashed on 05/02/2023.
//

import SwiftUI

struct BuySellCoinsView: View {
   
    @Binding var coin: CoinModel?
    
    var body: some View {
        NavigationView{
            VStack {
                if let coin = coin {
                    Text(coin.name)
                    Text(coin.id)
                    CoinImageView(coin: coin)
                }
            }
        }
    }
    
}
struct BuySellCoinsView2: PreviewProvider {
    static var previews: some View {
        BuySellCoinsView(coin: .constant(dev.coin))
        
    }
}


