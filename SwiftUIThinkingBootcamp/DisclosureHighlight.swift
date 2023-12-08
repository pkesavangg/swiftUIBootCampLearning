//
//  DisclosureHighlight.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 20/11/23.
//

import SwiftUI

struct DisclosureHighlight: View {
    @State private var expandedCategory: String? = nil
    @State private var foodCodeList: [String: [Int]] = ["Sample testing": [1, 2, 3]]

    var body: some View {
        List {
            ForEach(foodCodeList.sorted { $0.key < $1.key }, id: \.0) { (category, foodCodes) in
                DisclosureGroup(isExpanded: Binding(
                    get: { expandedCategory == category },
                    set: { expandedCategory = $0 ? category : nil }
                )) {
                    Text("foodCodes[0]")
                    Text("foodCodes[0]")
                    Text("foodCodes[0]")
                    Text("foodCodes[0]")
                } label: {
                    DisclosureLabel(category: category, count: "\(foodCodes.count)", isExpanded: expandedCategory == category)
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 20))
            }
        }
        .accentColor(Color(.green))
        .listStyle(GroupedListStyle())
        .padding(.top, -34)
        .onAppear {
            UIScrollView.appearance().bounces = false
        }
        .onDisappear {
            UIScrollView.appearance().bounces = true
        }
    }
}

struct DisclosureLabel: View {
    var category: String
    var count: String
    var isExpanded: Bool

    var body: some View {
        HStack {
            Text(category)
                .font(.callout)
                .padding(.leading, 20)
                .foregroundColor(isExpanded ? .white : .primary)
            Spacer()
            Text(count)
                .font(.footnote)
                .foregroundColor(isExpanded ? .white : .secondary)
            Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                .foregroundColor(isExpanded ? .white : .primary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            isExpanded ? Color.red : Color.clear // Change to your desired background color
        )
    }
}





#Preview {
    DisclosureHighlight()
}
