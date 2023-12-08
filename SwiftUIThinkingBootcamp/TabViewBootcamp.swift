//
//  TabViewBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 07/11/23.
//

import SwiftUI

struct TabViewBootcamp: View {
    @State private var selectedTab: Int = 0;
    let icons = ["heart.fill", "globe", "house.fill", "person.fill"]
    var body: some View {
        //        TabView {
        //            ForEach(icons, id: \.self) { icon in
        //                Image(systemName: icon)
        //                    .resizable()
        //                    .scaledToFit()
        //                    .padding(30)
        //            }
        //        }
        //        .background(Color.green)
        //        .frame(height: 300)
        //        .tabViewStyle(PageTabViewStyle())
        
        TabView(selection: $selectedTab,
                content:  {
            VStack{
                Text("Tab Content 1")
                Button("Move to tab 2") {
                    selectedTab = 2
                }
            }
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Favorites")
            }
            .tag(1)
            
            Text("Tab Content 2")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag(2)
        })
        .accentColor(.yellow)
    }
}

#Preview {
    TabViewBootcamp()
}
