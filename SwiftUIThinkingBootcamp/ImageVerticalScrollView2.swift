//
//  ImageVerticalScrollView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 22/12/23.
//

import SwiftUI


struct DashboardView: View {
    @State private var selectedTab = 0 // Initial tab index
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                ImageVerticalScrollView2()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)
                
                Text("Recipes")
                    .font(.title)
                    .fontWeight(.heavy)
                    .tabItem {
                        Label("Recipes", systemImage: "bookmark")
                    }
                    .tag(1)
                
                Text("Plan")
                    .font(.title)
                    .fontWeight(.heavy)
                    .tabItem {
                        Label("Plan", systemImage: "square.grid.2x2")
                    }
                    .tag(2)
                Text("Discover")
                    .font(.title)
                    .fontWeight(.heavy)
                    .tabItem {
                        Label("Discover", systemImage: "magnifyingglass")
                    }
                    .tag(3)
            }
            .onChange(of: selectedTab) { newTab in
                // This block will be called whenever the selected tab changes
                print("Selected tab is now \(newTab)")
            }
            .accentColor(Color.black)
        }
    }
}


struct ImageVerticalScrollView2: View {
    @State private var isProfileViewPresented = false
    @State private var isSettingsViewPresented = false
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(showsIndicators: false) {
                    Image("cooking_set")
                        .resizable()
                        .frame(height: 350)
                        .overlay {
                            VStack {
                                Spacer()
                                HStack {
                                    Button {
                                        isProfileViewPresented.toggle()
                                    } label: {
                                        Image(systemName: "person.crop.circle")
                                            .font(.title)
                                    }
                                    .sheet(isPresented: $isProfileViewPresented) {
                                        ProfileView()
                                    }
                                    
                                    Spacer()
                                    
                                    Button {
                                        isSettingsViewPresented.toggle()
                                    } label: {
                                        Image(systemName: "gearshape")
                                            .font(.title2)
                                    }
                                    .sheet(isPresented: $isSettingsViewPresented) {
                                        SettingsView()
                                    }
                                }
                                .padding(.leading)
                                .padding(.trailing)
                                .padding(.bottom, 60)
                                Spacer()
                                HStack {
                                    Text("Good morning!")
                                        .font(.title)
                                        .fontWeight(.heavy)
                                    Spacer()
                                }
                                .padding()
                            }
                        }
                    ConnectedDevicesHScrollView()
                    RecommenededHScrollView()
                    Spacer()
                }
                //                .toolbar(content: {
                //                    ToolbarItem(placement: .navigationBarLeading) {
                //                        NavigationLink {
                //                            ProfileView()
                //                        } label: {
                //                            Image(systemName: "person.crop.circle")
                //                                .font(.title2)
                //                        }
                //                    }
                //                    ToolbarItem(placement: .navigationBarTrailing) {
                //                        NavigationLink {
                //                            SettingsView()
                //                        } label: {
                //                            Image(systemName: "gearshape")
                //                                .font(.title2)
                //                        }
                //                    }
                //                })
                .accentColor(.black)
            }
            .edgesIgnoringSafeArea(.top)
            // .navigationTitle("Home")
        }
    }
}




struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationStack {
            VStack{
                Text("Profile View")
                    .font(.title)
                    .fontWeight(.heavy)
                
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Done")
                    })
                }
            })
        }
    }
}

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationStack {
            VStack{
                Text("Settings View")
                    .font(.title)
                    .fontWeight(.heavy)
                
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Done")
                    })
                }
            })
        }
    }
}


struct ConnectedDevicesHScrollView: View {
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Text("Connected Devices")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .padding(.leading)
                Spacer()
                NavigationLink {
                    HStack {
                        Text("Connected Devices List")
                            .font(.title)
                            .fontWeight(.heavy)
                    }
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.title3)
                        .padding(.trailing)
                }
                
                
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(1..<6) { value in
                        VStack(alignment: .leading, spacing: 15) {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 140, height: 120)
                                .cornerRadius(15)
                            Text("Device \(value)")
                        }
                        .padding(.leading)
                    }
                }
            }
        }
        .padding(.top)
    }
}

struct RecommenededHScrollView: View {
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Text("Recommened")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .padding(.leading)
                Spacer()
                
                
                NavigationLink {
                    HStack {
                        Text("Recommened Recipes List")
                            .font(.title)
                            .fontWeight(.heavy)
                    }
                } label: {
                    Text("View more")
                        .underline()
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.trailing)
                        .foregroundColor(Color.black)
                }
                
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(1..<15) { value in
                        VStack(alignment: .leading, spacing: 15) {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 280, height: 400)
                                .cornerRadius(15)
                            Text("Recipe \(value)")
                        }
                        .padding(.leading)
                    }
                }
            }
        }
        .padding(.top)
    }
}


struct ConnectedDevicesListView: View {
    var body: some View {
        Text("Connected Devices List")
    }
}


struct keyboardPickerView: View {
    @State private var selectedOption = 0
       let options = ["Option 1", "Option 2", "Option 3"]

       var body: some View {
           VStack {
               TextField("Select an option", text: Binding(
                   get: { options[selectedOption] },
                   set: { newText in
                       if let index = options.firstIndex(of: newText) {
                           selectedOption = index
                       }
                   }
               ))
               .textFieldStyle(RoundedBorderTextFieldStyle())

               Picker("Options", selection: $selectedOption) {
                   ForEach(0..<options.count) {
                       Text(options[$0])
                   }
               }
               .pickerStyle(.wheel)
           }
           .padding()
       }
}



#Preview {
//    CookingTimePicker(selectedHour: .constant(2), selectedMinute: .constant(2), isPresented: .constant(true))
    InputBoxView()
}

struct CookingTimePicker: View {
    @Binding public var selectedHour: Int
    @Binding public var selectedMinute: Int
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Button {
                            selectedHour = 0
                            selectedMinute = 0
                        } label: {
                            Text("Clear")
                        }
                            Spacer()
                        Button {
                            isPresented = false
                        } label: {
                            Text("Done")
                        }
                    }
                    .padding()
                    HStack {
                        Picker("Hours", selection: $selectedHour) {
                            ForEach(0..<101) { hour in
                                Text("\(hour) hr").tag(hour)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        //  .clipped()
                        
                        Picker("Minutes", selection: $selectedMinute) {
                            ForEach(0..<60) { minute in
                                Text("\(minute) min").tag(minute)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }

                }

                //   .clipped()
            }
            //.frame(maxWidth: .infinity)
            //            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.bottom))
            //            .padding()
            
            
        }
    }
}


enum addRecipeSections: String, CaseIterable {
    case Summary, Ingredients, Directions, Notes
}


struct CreateRecipeView: View {
    @State private var selectedOne: addRecipeSections = .Summary
    @State private var buttonTexts: [addRecipeSections] = [.Summary, .Ingredients, .Directions, .Notes]
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(buttonTexts, id: \.self) { val in
                            VStack {
                                Button(action: {
                                    withAnimation {
                                        selectedOne = val
                                    }
                                }, label: {
                                    Text(val.rawValue)
                                        .frame(height: 40)
                                        .padding(.horizontal)
                                        .foregroundColor(selectedOne == val ? Color.white : Color.black)
                                        .fontWeight(.semibold)
                                        .overlay( /// apply a rounded border
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(.black, lineWidth: 3)
                                            
                                        )
                                })
                                .background(selectedOne == val ? Color.black : Color.white)
                            }
                            
                        }
                    }
                    .padding(.vertical)
                    .padding(.leading)
                }
                switch self.selectedOne {
                case .Summary:
                    InputBoxView()
                case .Ingredients:
                    Text("Ingredients")
                case .Directions:
                    Text("Directions")
                case .Notes:
                    Text("Notes")
                }
                Spacer()
            }
            .navigationTitle("Create Recipe")
        }
    }
}

struct NoKeyboardTextField: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        var didBecomeFirstResponder = false
        var text: Binding<String>

        init(text: Binding<String>) {
            self.text = text
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            return false
        }
    }

    @Binding var text: String

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
}

struct InputBoxView: View {
    @FocusState private var fieldIsFocused: Bool
    @State private var title = ""
    @State private var selectedHour: Int = 0
    @State private var selectedMinute: Int = 0
    @State private var isEditingCookingTime = false
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(selectedHour) hr \(selectedMinute) min")
                .padding()
            
            TextField("Placeholder", text: $title)
                .frame(height: 50)
                .padding(.horizontal)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 3)
                )
                .focused($fieldIsFocused)
                .padding(.horizontal)
                .onTapGesture {
                    isEditingCookingTime = true
                    let resign = #selector(UIResponder.resignFirstResponder)
                    UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
                }
                .padding()
                
            
            Spacer()
            if  isEditingCookingTime {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(Color.white)
                    .frame(height: UIScreen.main.bounds.height * 0.3)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .transition(.move(edge: .bottom))
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .overlay {
                        CookingTimePicker(selectedHour: $selectedHour, selectedMinute: $selectedMinute, isPresented: $isEditingCookingTime)
                    }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}


import SwiftUI

struct MultiComponentPicker<Tag: Hashable>: View  {
    let columns: [Column]
    var selections: [Binding<Tag>]
    
    init?(columns: [Column], selections: [Binding<Tag>]) {
        guard !columns.isEmpty && columns.count == selections.count else {
            return nil
        }
        
        self.columns = columns
        self.selections = selections
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(0 ..< columns.count) { index in
                    let column = columns[index]
                    ZStack(alignment: Alignment.init(horizontal: .customCenter, vertical: .center)) {
                        if (!column.label.isEmpty && !column.options.isEmpty) {
                            HStack {
                                Text(verbatim: column.options.last!.text)
                                    .foregroundColor(.clear)
                                    .alignmentGuide(.customCenter) { $0[HorizontalAlignment.center] }
                                Text(column.label)
                            }
                        }
                        Picker(column.label, selection: selections[index]) {
                            ForEach(column.options, id: \.tag) { option in
                                Text(verbatim: option.text).tag(option.tag)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: geometry.size.width / CGFloat(columns.count), height: geometry.size.height)
                        .clipped()
                    }
                    
                }
            }
        }
    }
}

extension MultiComponentPicker {
    struct Column {
        struct Option {
            var text: String
            var tag: Tag
        }
        
        var label: String
        var options: [Option]
    }
}

private extension HorizontalAlignment {
    enum CustomCenter: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat { context[HorizontalAlignment.center] }
    }
    
    static let customCenter = Self(CustomCenter.self)
}

// MARK: - Demo preview
//struct MultiComponentPicker_Previews: PreviewProvider {
//    static var columns = [
//        MultiComponentPicker.Column(label: "h", options: Array(0...23).map { MultiComponentPicker.Column.Option(text: "\($0)", tag: $0) }),
//        MultiComponentPicker.Column(label: "min", options: Array(0...59).map { MultiComponentPicker.Column.Option(text: "\($0)", tag: $0) }),
//        MultiComponentPicker.Column(label: "sec", options: Array(0...59).map { MultiComponentPicker.Column.Option(text: "\($0)", tag: $0) }),
//    ]
//
//    static var selection1: Int = 23
//    static var selection2: Int = 59
//    static var selection3: Int = 59
//
//    static var previews: some View {
//        MultiComponentPicker(columns: columns, selections: [.constant(selection1), .constant(selection2), .constant(selection3)]).frame(height: 300).previewLayout(.sizeThatFits)
//    }
//}
