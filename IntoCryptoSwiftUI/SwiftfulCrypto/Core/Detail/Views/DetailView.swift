
import SwiftUI

struct DetailLoadingView: View {
    @Binding  var showBuySellView: Bool
    @Binding var coin: CoinModel?
   
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin , b: $showBuySellView)
            }
        }
    }
    
}

struct DetailView: View {


    @StateObject private var vm: DetailViewModel
    @State private var showFullDescription: Bool = false
    @Binding  var showBuySellView: Bool
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel , b : Binding<Bool>) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
       _showBuySellView = b
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                
                VStack(alignment: .center, spacing: 20) {
                    Spacer()
                    overviewTitle
                    Divider()
            
                    overviewGrid
                    
                    additionalGrid
                    
                }.padding()
                Spacer()
                VStack{
                    Text("Want to trade this coin?") .font(Font.system(size: 14).italic().bold()).padding()
                    
                
                           
                           
                 NavigationLink(destination: BuySellCoinsView(coin:.constant(vm.coin) , showBuySellView: $showBuySellView), label: {
                 
                        Text("Start Trading!")
                         .frame(width: 250,height:10 ,alignment: .center)
                                       .font(.system(size: 18))
                                       .padding()
                                       .foregroundColor(Color("MainColor"))
                .overlay(
                     RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.theme.accent, lineWidth: 12)
                               )
               
                 }).background(Color("SecondMainColor"))
                 .fontWeight(.semibold)
                           
                }
             
            }
        }
        .background(
            Color.theme.background
                .ignoresSafeArea()
        )
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItems
            }
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin, b: .constant(true))
        }
    }
}

extension DetailView {
    
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = vm.coinDescription,
               !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)

                    Button(action: {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    }, label: {
                        Text(showFullDescription ? "Less" : "Read more..")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    })
                    .accentColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }
        })
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
        })
    }
    
 
    
}
