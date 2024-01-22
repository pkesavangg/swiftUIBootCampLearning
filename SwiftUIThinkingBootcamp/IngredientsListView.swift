//
//  IngredientsListView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 27/12/23.
//

import SwiftUI

struct IngredientsListView: View {
    @State private var ingredients: [String] = [""]
    @State private var newIngredient = ""
    
    init() {
        _ingredients = State(initialValue: ["1244", "", ""])
        
    }
    var body: some View {
        VStack(spacing: 30) {
            Button(action: {
                // Add functionality to execute when the "Add Ingredient" button is tapped
                addIngredient()
            }) {
                Text("Add Ingredient")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            ForEach(0..<ingredients.count, id: \.self) { index in
                HStack {
                    Spacer()
//                    TextField("Ingredient", text: $ingredients[index])
//                        .padding(.vertical, 10)
//                        .background(
//                            VStack {
//                                Spacer()
//                                
//                            }
//                        )
                    Rectangle()
                        .fill(Color.black)
                        .frame(height: 1.5)
                        
                        .overlay {
                            HStack {
                                Text(ingredients[index])
                                Spacer()
                                Button(action: {
                                    // Add functionality to execute when the "Remove" button is tapped
                                    removeIngredient(at: index)
                                }) {
                                    Image(systemName: "pencil")
                                        .font(.title2)
                                        .foregroundColor(.black)
                                        .padding(.trailing)
                                }
                                
                                Button(action: {
                                    // Add functionality to execute when the "Remove" button is tapped
                                    removeIngredient(at: index)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.black)
                                }
                                
                            }
                            .padding(.bottom, 30)
                            
                        }
                        .padding(.vertical, 20)
                }
            }
            Spacer()
        }
        .padding()
    }
    
    private func addIngredient() {
        // Append a new ingredient to the array
        ingredients.append(newIngredient)
        
        // Clear the newIngredient variable for the next input
        newIngredient = ""
    }
    
    private func removeIngredient(at index: Int) {
        // Remove the ingredient at the specified index
        ingredients.remove(at: index)
    }
}

struct IngredientsListView2: View {
    @State private var ingredients: [String] = ["testing"]
    @State private var newIngredient = ""
    @State private var isAddingIngredient = false
    @State private var isEditingIngredient = false
    @State private var editedIngredientIndex = 0
    @State private var editedIngredientValue = ""

    var body: some View {
        VStack(spacing: 30) {
            Button(action: {
                // Show the alert for adding a new ingredient
                isAddingIngredient = true
            }) {
                Text("Add Ingredient")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .alert("Add Ingredient", isPresented: $isAddingIngredient) {
                TextField("Enter Ingredient", text: $newIngredient)
                Button("Cancel", action: {})
                Button("Add", action: addIngredient)
                
            } message: {
                Text("Please enter your ingredient")
            }

            ForEach(0..<ingredients.count, id: \.self) { index in
                HStack {
                    
                    HStack {
                        Spacer()
                        Text(ingredients[index])
                       
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        VStack {
                            Spacer()
                            Rectangle()
                                .fill(Color.black)
                                .frame(height: 1.5)
                        }
                    )

                    .overlay {
                        HStack {
                            Spacer()
                            Button(action: {
                                // Show the alert for editing the ingredient
                                editedIngredientIndex = index
                                editedIngredientValue = ingredients[index]
                                isEditingIngredient = true
                            }) {
                                Image(systemName: "pencil")
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .padding(.trailing)
                            }

                            Button(action: {
                                // Add functionality to execute when the "Remove" button is tapped
                                removeIngredient(at: index)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .padding()
        .alert("Edit Ingredient", isPresented: $isEditingIngredient) {
            TextField("Edit Ingredient", text: $editedIngredientValue)
            Button("Cancel") {
                // Reset editing states
                editedIngredientIndex = 0
                editedIngredientValue = ""
                isEditingIngredient = false
            }
            
            Button("Save") {
                // Update the ingredient at the specified index
                if editedIngredientIndex < ingredients.count {
                    ingredients[editedIngredientIndex] = editedIngredientValue
                }
                // Reset editing states
                editedIngredientIndex = 0
                editedIngredientValue = ""
                isEditingIngredient = false
            }
        }
    }

    private func addIngredient() {
        // Append a new ingredient to the array
        ingredients.append(newIngredient)

        // Clear the newIngredient variable for the next input
        newIngredient = ""
    }

    private func removeIngredient(at index: Int) {
        // Remove the ingredient at the specified index
        ingredients.remove(at: index)
    }
}



#Preview {
    IngredientsListView()
}




struct TextEditorView: View {
    
    @State var string: String = ""
    @State var textEditorHeight : CGFloat = 20
    
    var body: some View {
        
        HStack {
                      ZStack {
                        TextEditor(text: $string)
                        Text(string).opacity(0).padding(.all, 8)
                      }
                      Spacer()
                      Button(action: {
                        // Remove item from list
//                        if let index = ingredients.firstIndex(of: item) {
//                          ingredients.remove(at: index)
//                        }
                      }) {
                        Image(systemName: "trash")
                          .foregroundColor(.red)
                      }
                    }
                  }
        
    }
    



struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}
