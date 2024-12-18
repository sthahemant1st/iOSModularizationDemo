//
//  DashboardScreen.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//

import SwiftUI

struct DashboardScreen: View {
    var homeScreenDelegate: HomeScreenDelegate?
    
    init(homeScreenDelegate: HomeScreenDelegate?) {
        self.homeScreenDelegate = homeScreenDelegate
    }
    
    var body: some View {
        VStack {
            TabView {
                HomeScreen(homeScreenDelegate: homeScreenDelegate)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                SettingsScreen()
                    .tabItem {
                        Label("Setting", systemImage: "gear")
                    }
            }
        }
        .navigationTitle("Dahsboard")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    NavigationView {
        DashboardScreen(homeScreenDelegate: nil)
    }
}
