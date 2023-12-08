//
//  EnvironmentBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 10/11/23.
//

import SwiftUI

class EnvironmentViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    init() {
        self.getArray();
    }
    
    func getArray() {
        dataArray.append(contentsOf: ["iPhone", "iPad", "iMac", "Apple Watch"])
    }
}


class EnvironmentViewModel2: ObservableObject {
    @Published var dataArray: [String] = []
    
    init() {
        self.getArray();
    }
    
    func getArray() {
        dataArray.append(contentsOf: ["123", "456", "789", "0123"])
    }
}


struct EnvironmentBootcamp: View {
    @StateObject var viewModel = EnvironmentViewModel()
    @StateObject var viewModel2 = EnvironmentViewModel2()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.dataArray, id: \.self) { data in
                    NavigationLink {
                        DetailView(selectedItem: data)
                    } label: {
                        Text(data)
                    }
                }
            }
            .navigationTitle("Devices")
        }
        .environmentObject(viewModel)
        .environmentObject(viewModel2)
    }
}

struct DetailView: View {
    let selectedItem: String
    
    var body: some View {
        
        NavigationLink(destination: FinalView()) {
            Text(selectedItem)
                .font(.largeTitle)
                .frame(height: 40)
                .padding()
                .background(Color.yellow)
                .cornerRadius(15)
        }
    }
}

struct FinalView: View {
    @EnvironmentObject var viewModel : EnvironmentViewModel
    @EnvironmentObject var viewModel2 : EnvironmentViewModel2
    var body: some View {
        VStack {
            ForEach(viewModel.dataArray, id: \.self) { data in
                Text(data)
                    .font(.largeTitle)
                    .frame(height: 40)
                    .padding()
                    .cornerRadius(15)
            }
            
            ForEach(viewModel2.dataArray, id: \.self) { data in
                Text(data)
                    .font(.largeTitle)
                    .frame(height: 40)
                    .padding()
                    .cornerRadius(15)
            }
        }
        
    }
}



#Preview {
    EnvironmentBootcamp()
    //DetailView(selectedItem: "iPhone")
}
