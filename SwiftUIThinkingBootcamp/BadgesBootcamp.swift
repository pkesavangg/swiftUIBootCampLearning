//
//  BadgesBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 11/11/23.
//

import SwiftUI

struct BadgesBootcamp: View {
    var body: some View {
        
        List{
            Text("Favorites")
                .badge(23)
            Text("Favorites")
                .badge("23")
            Text("Favorites")
        }
        
        
//        TabView {
//            Color.red
//                .tabItem {
//                    Image(systemName: "heart.fill")
//                    Text("Favorites")
//                }
//            Color.green
//                .tabItem {
//                    Image(systemName: "heart.fill")
//                    Text("List")
//                }
//                .badge(23)
//            Color.purple
//                .tabItem {
//                    Image(systemName: "heart.fill")
//                    Text("Settings")
//                }
//                .badge("new")
//        }
       
    }
}

#Preview {
    BadgesBootcamp()
}
