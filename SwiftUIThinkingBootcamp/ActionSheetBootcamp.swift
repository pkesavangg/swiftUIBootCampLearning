//
//  ActionSheetBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 05/11/23.
//

import SwiftUI

struct ActionSheetBootcamp: View {
    @State private var showActionSheet = false
    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        self.showActionSheet = true
                    }
                    .actionSheet(isPresented: $showActionSheet, content: {
                        ActionSheet(title: Text("Action sheet"),
                                    message: Text("Action sheet opened"),
                                    buttons: [.destructive(Text("Delete"), action: {}),
                                              .default(Text("Default"), action: {}),
                                              .cancel(Text("Default"), action: {})])
                            
                    })
            }
        }
    }
}

#Preview {
    ActionSheetBootcamp()
}
