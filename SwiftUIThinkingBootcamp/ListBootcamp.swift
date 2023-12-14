//
//  ListBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 05/11/23.
//

import SwiftUI

struct ListBootcamp: View {
    @State private var fruits = ["Apple", "Orange", "Mango", "Peaches", "Guava"]
    var body: some View {
        NavigationView{
            List {
                Section {
                    ForEach(fruits, id: \.self) { item in
                        Text(item)
                    }
                    .onDelete(perform: deleteItem)
                    .onMove(perform: moveItem)
                    .onInsert(of: fruits, perform: { index, items in
                        print(index, items)
                    })
                } header: {
                    Text("Fruits")
                }
                .listRowBackground(Color.red)
                .listRowSeparator(.hidden)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Groceries")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: EditButton(),
                                trailing: addButton)
        }
    }
    
    var addButton : some View {
        Button("Add") {
            fruits.append("Pomogranate")
        }
    }
    
    func deleteItem(indexSet: IndexSet) {
        fruits.remove(atOffsets: indexSet)
    }
    
    func moveItem(indices: IndexSet, newOffset: Int) {
        fruits.move(fromOffsets: indices, toOffset: newOffset)
    }
}

#Preview {
    ListBootcamp()
}
