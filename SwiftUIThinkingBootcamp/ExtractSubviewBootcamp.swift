//
//  ExtractSubviewBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 04/11/23.
//

import SwiftUI

struct ExtractSubviewBootcamp: View {
    var body: some View {
        
        ZStack(content: {
            Color.purple
                .ignoresSafeArea()
            contentsView
        })
    }
    
    var contentsView: some View {
        HStack {
            MyItem(title: "Apple", count: 2, backgroundColor: .white)
            MyItem(title: "Orange", count: 5, backgroundColor: .yellow)
            MyItem(title: "Peaches", count: 7, backgroundColor: .blue)
        }
    }
}

#Preview {
    ExtractSubviewBootcamp()
}

struct MyItem: View {
    let title: String;
    let count: Int;
    let backgroundColor: Color
    
    var body: some View {
        VStack(content: {
            RoundedRectangle(cornerRadius: 25)
                .fill(backgroundColor)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                .overlay {
                    VStack{
                        Text(title)
                            .foregroundColor(.brown)
                            .fontWeight(.bold)
                        Text("\(count)")
                            .foregroundColor(.brown)
                            .fontWeight(.bold)
                    }
                }
        })
    }
}
