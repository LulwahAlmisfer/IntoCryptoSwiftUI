//
//  coinsViewlist.swift
//  SwiftfulCrypto
//
//  Created by lulwah on 09/01/2023.
//

import SwiftUI

struct coinsViewlist: View {
    @State var i = 1
    @EnvironmentObject private var vm: HomeViewModel
    var body: some View {
        TabView(selection: $i ) {

            allCoinsList.tabItem { Image(systemName: "house") }.tag(1)
            Text("Tab Label 2").tabItem { Text("Tab Label 2") }.tag(2)
        }
    }
}

struct coinsViewlist_Previews: PreviewProvider {
    static var previews: some View {
        
        coinsViewlist()
            .environmentObject(dev.homeVM)
    }
}
extension coinsViewlist{
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                   
                    .listRowBackground(Color.theme.background)
            }
        }
        .listStyle(PlainListStyle())
    }
}
