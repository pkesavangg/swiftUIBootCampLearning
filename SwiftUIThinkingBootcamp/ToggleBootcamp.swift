//
//  ToggleBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 05/11/23.
//

import SwiftUI

struct ToggleBootcamp: View {
    @State private var isToggleOn = false
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Status:")
                    Text(isToggleOn ? "Online" : "Offline")
                }
                
                Toggle(isOn: $isToggleOn, label: {
                    Text("Change status:")
                })
                .padding(.horizontal, 100)
                Spacer()
            }
        }
    }
}

#Preview {
    ToggleBootcamp()
}
