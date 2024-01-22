//
//  TabBarHiddenView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 30/12/23.
//

import SwiftUI

import SwiftUI

struct TabBarHiddenView: View {
    @State private var selection: Tab = .home

        enum Tab {
            case home
            case discover
        }
    var body: some View {
        VStack {
            TabView {
                HomeView()
                    .font(.title)
                    .fontWeight(.heavy)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(Tab.home)
                Text("Discover")
                    .font(.title)
                    .fontWeight(.heavy)
                    .tabItem {
                        Label("Discover", systemImage: "magnifyingglass")
                    }
                    .tag(Tab.discover)
            }
            
        }
    }
}

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    SubView()
                } label: {
                    Text("Go to Subview")
                }
            }
        }
        .navigationBarHidden(true) // Hide the navigation bar when inside HomeView
    }
}

struct SubView: View {
    var body: some View {
        Text("Subview")
            .toolbar(.hidden, for: .tabBar)

    }
}



#Preview {
    TabBarHiddenView()
}
