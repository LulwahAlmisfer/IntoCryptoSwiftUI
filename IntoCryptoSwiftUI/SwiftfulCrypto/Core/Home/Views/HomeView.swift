

import SwiftUI

struct HomeView: View { //TODO: change the name HomeView to mainTabView
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var service: SessionServiceImpl
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false // animate right
    @State private var showPortfolioView: Bool = false // new sheet
    @State private var showSettingsView: Bool = false // new sheet
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    @State private var showBuySellView: Bool = false
    @State var selector = 1
    @AppStorage("WalletCredit") var WalletCredit : Double = 100000
    var body: some View {
        ZStack {
            
            // background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
            
            // content layer
            VStack {
                
                if selector != 3 {
                    homeHeader
                }
                
                if selector == 2 {
                    
                    Text("Balance: \(WalletCredit, specifier: "%.0f")").bold().italic().padding(.top).foregroundColor(.gray)
                }
                if selector == 1 {
                    portfolioCoinsListH.padding(.leading)
                    SearchBarView(searchText: $vm.searchText)
                }
                
                if selector == 1 {
                    columnTitles
                }
                
                
                TabView(selection: $selector) {
                    
                    allCoinsList.tabItem {
                        VStack {
                            Image(systemName: "house")
                            Text("Home")
                        } }.tag(1)
                    
                    portfolioCoinsList
                        .tabItem {
                        VStack {
                            Image(systemName: "creditcard")
                            Text("Portfolio")
                        }}.tag(2)
                    
                    Profile(name: service.userDetails?.Name ?? "temp")  .environmentObject(service).tabItem{
                        VStack {
                            Image(systemName: "person")
                            Text("Profile")
                        }}.tag(3)
                    
                }.background(Color("MainColor"))
                
                Spacer(minLength: 0)
            }
            
        }
        
        .background(
            NavigationLink(
                destination: DetailLoadingView(showBuySellView: $showDetailView, coin: $selectedCoin),
                isActive: $showDetailView,
                label: { EmptyView() })
        )
        .background(
            NavigationLink(
                destination: BuySellCoinsView(coin: $selectedCoin, showBuySellView: $showBuySellView ),
                isActive: $showBuySellView,
                label: { EmptyView() })
        )
        
        
    }
    
    
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
            
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
        .environmentObject(SessionServiceImpl())
    }
}

extension HomeView {
    
    private var homeHeader: some View {
        HStack {
        
            Text(showPortfolio ? "Portfolio" : LocalizedStringKey("Live Prices"))
            
                .font(Font.title2)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
    
         
            
        }.padding(.top,30)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
                    .listRowBackground(Color.theme.background)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList: some View {
        List {
            
            ForEach(vm.portfolioCoins) { coin in
                
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        presentBuySellView(coin: coin)
                    }
                    .listRowBackground(Color.theme.background)
            }
        }
        .background{
            Color.theme.background
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsListH: some View {
        ScrollView(.horizontal , showsIndicators: false){
            
            HStack {
                ForEach(vm.portfolioCoins ) { coin in
                    CoinRowView(coin: coin, showHoldingsColumn: true)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                        .onTapGesture {
                            segue(coin: coin)
                        }
                        .listRowBackground(Color.theme.background)
                }
            }
            
        }
        .listStyle(PlainListStyle())
    }
    
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    private func presentBuySellView(coin: CoinModel) {
        //present the buySellView and pass the coin
        selectedCoin = coin
        showBuySellView.toggle()
    }
    
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
            Button(action: {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            }, label: {
                Image(systemName: "goforward")
            })
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
}


struct tab : View{
    @Binding var shouldshowonb :Bool
    var body: some View {
        
        ZStack{
            Color("main").ignoresSafeArea(.all)
            TabView{
                OnBoarding1View(shouldshowonb: $shouldshowonb)
                OnBoarding2View(shouldshowonb: $shouldshowonb)
            }.tabViewStyle(PageTabViewStyle())
        }.ignoresSafeArea()
        
    }
    
}
