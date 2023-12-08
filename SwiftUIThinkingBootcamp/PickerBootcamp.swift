//
//  PickerBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 05/11/23.
//

import SwiftUI

struct PickerBootcamp: View {
    @State private var selectedOne = "Most recent"
    let filteredOptions = ["Most Popular", "Most recent", "Most liked"]
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .red
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.white
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
    }
    var body: some View {
        NavigationView {
            VStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Selected Option: \(selectedOne)")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                Picker(selection: $selectedOne) {
                    ForEach(filteredOptions, id: \.self) { option in
                        Text(option)
                            .tag(option)
                    }
                } label: {
                    Text("Picker")
                }
                //                .pickerStyle(.wheel)
                //                .pickerStyle(.menu)
                .pickerStyle(.segmented)
            }
        }
    }
}

#Preview {
    PickerBootcamp()
}
