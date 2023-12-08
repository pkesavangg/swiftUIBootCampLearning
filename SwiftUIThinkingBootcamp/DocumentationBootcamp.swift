//
//  DocumentationBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 07/11/23.
//

import SwiftUI

struct DocumentationBootcamp: View {
    //MARK: PROPERTIES
    
    let values = ["Apples", "Oranges", "Peaches"]
    @State private var showAlert = false;
    
    //MARK: BODY
    var body: some View {
        NavigationView {
            VStack {
                scrollView
            }
            .navigationTitle("Fruits List")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showAlert, content: {
                getAlert(titleMessage: "This is a alert")
            })
        }
    }
    
    ///This is scrollView that holds the iterating values
    var scrollView : some View {
        ScrollView {
            ForEach(values, id: \.self) { fruit in
                Text(fruit)
                    .frame(width: 100, height: 100)
                    .background(Color.red)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
    }
    
    //MARK: FUNCTIONS
    
    
    
    /// This function used to show the Alert
    ///
    ///This function creates and returns an alert immediately.  The alert will have text based on title parameter
    ///
    ///  ```
    ///     getAlert(titleMessage: "Hi") -> Alert(titleMessage: "Hi")
    ///  ```
    ///
    /// - Warning: There is no additional message in this Alert
    /// - Parameter titleMessage: This is the title for the Alert
    /// - Returns: Returns an alert with a titleMessage
    private func getAlert(titleMessage: String) -> Alert {
        return Alert(title: Text(titleMessage))
    }
    
    
}

#Preview {
    DocumentationBootcamp()
}
