//
//  DirectionListView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 27/12/23.
//

import SwiftUI

//struct RecipeDirectionStructure {
//    var title: String
//    var description: String
//    var timers: [Int]? //[seconds]
//    var temperature: [Double]?
//}

//struct DirectionListView: View {
//    @State private var descriptions: [RecipeDirectionStructure] = []
//    @State private var newDescription: RecipeDirectionStructure = RecipeDirectionStructure(title: "Testing", description: "Testing desc")
//    @State public var showAddDescriptionView = false
//    @State public var title = ""
//    @State public var description = ""
//    @State public var editedDirectionIndex: Int?
//    init() {
//        _descriptions = State(initialValue: [RecipeDirectionStructure(title: "Testing", description: "Testing desc"), RecipeDirectionStructure(title: "Testing", description: "Testing desc"),
//                                             RecipeDirectionStructure(title: "Testing", description: "Testing desc")])
//        
//    }
//    var body: some View {
//        VStack(spacing: 30) {
//            Button(action: {
//                // Add functionality to execute when the "Add Ingredient" button is tapped
//                // addIngredient()
//                showAddDescriptionView = true
//            }) {
//                Text("Add Description")
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.black)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .sheet(isPresented: $showAddDescriptionView, onDismiss: {
//                if let index = editedDirectionIndex {
//                    // Editing an existing direction
//                    if index < descriptions.count {
//                        descriptions[index].title = title
//                        descriptions[index].description = description
//                        editedDirectionIndex = nil
//                    }
//                } else {
//                    // Adding a new direction
//                    descriptions.append(RecipeDirectionStructure(title: title, description: description))
//                }
//                // Clear the input fields
//                title = ""
//                description = ""
//            } ,content: {
//                AddDescriptionView(title: $title, description: $description)
//            })
//            
//            ScrollView(.vertical, showsIndicators: false) {
//                VStack(spacing: 20) {
//                    ForEach(0..<descriptions.count, id: \.self) { index in
//                        HStack {
//                            //TextField("Ingredient", text: $ingredients[index])
//                            Color.gray
//                                .frame(height: 300)
//                                .frame(maxWidth: .infinity)
//                                .background(Color.gray)
//                                .cornerRadius(10)
//                                .overlay {
//                                    VStack {
//                                        HStack {
//                                            Text("\(index + 1). \(descriptions[index].title)")
//                                                .fontWeight(.semibold)
//                                                .padding()
//                                            Spacer()
//                                        }
//                                        HStack {
//                                            Text("\(descriptions[index].description)")
//                                                .padding(.leading, 30)
//                                            Spacer()
//                                        }
//                                        
//                                        Spacer()
//                                        HStack(spacing: 20) {
//                                            Spacer()
//                                            Button(action: {
//                                                showAddDescriptionView = true
//                                                                               title = descriptions[index].title
//                                                                               description = descriptions[index].description
//                                                                               editedDirectionIndex = index
//                                            }) {
//                                                Image(systemName: "pencil")
//                                                    .font(.title2)
//                                                    .foregroundColor(.black)
//                                                    .padding(.trailing)
//                                            }
//                                            
//                                            Button(action: {
//                                                // Add functionality to execute when the "Remove" button is tapped
//                                                removeIngredient(at: index)
//                                            }) {
//                                                Image(systemName: "trash")
//                                                    .foregroundColor(.black)
//                                            }
//                                        }
//                                        .padding()
//                                    }
//                                    
//                                }
//                        }
//                    }
//                }
//            }
//        }
//        .padding(.horizontal)
//    }
//    
//    private func addIngredient() {
//        descriptions.append(newDescription)
//        newDescription = RecipeDirectionStructure(title: "", description: "")
//    }
//    
//    private func removeIngredient(at index: Int) {
//        // Remove the ingredient at the specified index
//        descriptions.remove(at: index)
//    }
//}

//#Preview {
   // DirectionListView()
    //AddDescriptionView(title: .constant(""), description: .constant(""))
//}


struct AddDescriptionView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Binding public var title: String
    @Binding public var description: String
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                VStack(alignment: .leading) {
                    Text("Title")
                        .fontWeight(.semibold)
                    TextField("Required", text: $title)
                        .padding()
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 3)
                        )
                }
                VStack(alignment: .leading) {
                    Text("Description")
                        .fontWeight(.semibold)
                    TextEditor(text: $description)
                        .padding()
                        .frame(height: 300)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 3)
                        )
                }
                Spacer()
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        title = ""
                        description = ""
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            })
            .padding()
        }
    }
}


