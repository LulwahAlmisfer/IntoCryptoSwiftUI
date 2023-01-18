//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Nick Sarno on 5/8/21.
//

import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      
   
    return true
  }
}


@main
struct SwiftfulCryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    @State private var showLaunchView: Bool = true
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sessionService = SessionServiceImpl()
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().tintColor = UIColor(Color.theme.accent)
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    switch sessionService.state {
                        case .loggedIn:
                            HomeView()
                                .environmentObject(sessionService)
                                .navigationBarHidden(true)
                        case .loggedOut:
                            LoginView()
                        }
                    //HomeView()
                      //  .navigationBarHidden(true)
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .environmentObject(vm)

//                ZStack {
//                    if showLaunchView {
//                        LaunchView(showLaunchView: $showLaunchView)
//                            .transition(.move(edge: .leading))
//                    }
//                }
//                .zIndex(2.0)
            }
        }
    }
}
