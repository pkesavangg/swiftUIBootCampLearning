//
//  ViewModelBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 08/11/23.
//

import SwiftUI

struct FruitModel: Identifiable {
    let id = UUID().uuidString
    let fruitName: String
    let count: Int
}

class FruitViewModel: ObservableObject {
    @Published var fruits: [FruitModel] = []
    
    init() {
        fruits.append(FruitModel(fruitName: "Apples", count: 5))
        fruits.append(FruitModel(fruitName: "Oranges", count: 15))
        fruits.append(FruitModel(fruitName: "Peaches", count: 25))
    }
    
    func deleteFruit(index: IndexSet) {
        fruits.remove(atOffsets: index)
    }
}

struct ViewModelBootcamp: View {
    // @StateObject ->Not Get updated for every time view refresh  USE THIS FOR SUBVIEWS
    // @ObservedObject -> Get updated for every time view refresh USE THIS FOR CREATION/ INIT
    @ObservedObject private var viewModel = FruitViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.fruits) { fruit in
                    Text(fruit.fruitName)
                }
                .onDelete(perform: viewModel.deleteFruit)
            }
            .navigationBarItems(leading:
                                    NavigationLink("Go ->", destination: {
                SecondViewFruitView(fruitViewModel: viewModel)
            })
                                    
            )
            .onAppear{
               // viewModel.getFruits()
            }
            .navigationTitle("Fruits")
        }
        
    }
}


struct SecondViewFruitView: View {
    
    @ObservedObject var fruitViewModel: FruitViewModel
    var body: some View {
        
        List{
                ForEach(fruitViewModel.fruits) { fruit in
                    Text(fruit.fruitName)
                }
                .onDelete(perform: fruitViewModel.deleteFruit)
            
        }

    }
}

#Preview {
    ViewModelBootcamp()
}
