//
//  DogeCoinFetch_iOSApp.swift
//  DogeCoinFetch-iOS
//
//  Created by BOONGKI KWAK on 2023/02/27.
//

import SwiftUI

@main
struct DogeCoinFetch_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                
                PriceViewController.instantiate("PriceViewController").getRepresentable()
                    .tabItem {
                        Image(systemName: "list.bullet.rectangle")
                        Text("UIKit")
                    }
                ContentView()
                    .tabItem {
                        Image(systemName: "list.bullet.rectangle")
                        Text("SwiftUi")
                    }
            }
        }
    }
}
