//
//  NavigationViewLearning.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 04/11/23.
//

import SwiftUI

struct NavigationViewLearning: View {
    var body: some View {
        
        NavigationView(content: {
            VStack(content: {
                NavigationLink("Hello world", destination: NavigationView2())
                    .navigationTitle("Main view")
                    .navigationBarTitleDisplayMode(.inline)
                    //.navigationBarHidden(true)
                    .navigationBarItems(leading:
                        Text("1")
                    , trailing:
                        Text("1")
                    )
            })
        })
        
    }
}

struct NavigationView2: View {
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        VStack(content: {
            NavigationLink(destination: Text("Destination")) { Text("Navigate") }
                .accentColor(.red)
            
            Button("Close") {
                presentationMode.wrappedValue.dismiss()
            }
            
        })
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationViewLearning()
}
