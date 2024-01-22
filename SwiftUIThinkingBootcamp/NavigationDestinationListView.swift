//
//  NavigationDestinationListView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 04/01/24.
//

import SwiftUI

struct NavigationDestinationListView: View {
    @State var list: [String: [String]] = {
        var dictionary: [String: [String]] = [:]
        
        for number in 1...10 {
            let spelledOutWords = (1...number).map {
                NumberFormatter.localizedString(from: NSNumber(value: $0), number: .spellOut)
            }
            dictionary[String(number)] = spelledOutWords
        }
        
        return dictionary
    }()
    @State var search: String = ""
    
    var body: some View {
        NavigationStack {
                List {
                    ForEach(list.sorted(by: { $0.key < $1.key }), id: \.key) { key, values in
                        ExtractedView32(key: key, values: values)
                }
                
            }
            .searchable(text: $search)
            .navigationTitle("Number List")
            
        }
    }
}


struct ExtractedView32: View {
    var key: String
    var values: [String]
    @State var showListView: Bool = false
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Number \(key):")
                        .font(.headline)
                    
                    Button(action: {
                        showListView = true
                    }, label: {
                        Text("Show List")
                    })
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(values, id: \.self) { value in
                            Text(value)
                        }
                    }
                }
            }
           
            .navigationDestination(isPresented: $showListView) {
                ListView(key: key, values: values)
            }
        }
        
    }
}

struct ListView: View {
    var key: String
    var values: [String]
    var body: some View {
        List(values, id: \.self) { value in
            HStack {
                Text(value)
            }
            .navigationTitle("Selected Number: \(key)")
        }
    }
}

#Preview {
    NavigationDestinationListView()
}
