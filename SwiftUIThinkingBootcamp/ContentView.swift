//
//  ContentView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 30/10/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var originalImage = UIImage(named: "google-icon")!
    var body: some View {
        DetectFacialExpression()
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}






