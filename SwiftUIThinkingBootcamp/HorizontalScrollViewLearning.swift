//
//  HorizontalScrollViewLearning.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 03/01/24.
//

import SwiftUI

struct HorizontalScrollViewLearning: View {
    @State private var selectedOne: Int = 1
    @State private var currentPage: Int = 1
    @State private var scrollToSelected: Bool = false
    @State private var contentHeights: [Int: CGFloat] = [:]
    var body: some View {
        VStack {
            Spacer()
            ScrollView {
                VStack {
                    VStack {
                        // Image place holder
                        Rectangle()
                            .fill(Color.gray)
                            .frame(height: 250)
                        
                    }
                    HStack {
                        Text("recipeInfo.name and fercy burger" )
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    .padding()
                    ScrollViewReader { scrollView in
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack(spacing: 10) {
                                ForEach(1...5, id: \.self) { number in
                                    Button {
                                        selectedOne = number
                                        currentPage = number
                                        withAnimation {
                                            scrollToSelected = true
                                        }
                                    } label: {
                                        Text("\(number)")
                                            .frame(width: 100, height: 50)
                                            .background(self.selectedOne == number ? .green : Color.gray)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                            .id(number) // Ensure each view has a unique identifier
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .onChange(of: scrollToSelected) { scrollToSelected in
                                if scrollToSelected {
                                    withAnimation {
                                        scrollView.scrollTo(selectedOne, anchor: .center)
                                    }
                                    self.scrollToSelected = false
                                }
                            }
                        }
                    }
                    
                    TabView(selection: $currentPage) {
                        ForEach(1...5, id: \.self) { number in
                            getView(for: number)
                                .background(
                                    GeometryReader { geometry in
                                        Color.clear
                                            .onAppear {
                                                contentHeights[number] = geometry.size.height
                                            }
                                    }
                                )
                                
                                .tag(number)
                        }
                        
                    }
                    .frame(height: contentHeights[selectedOne])
                    .animation(.easeInOut, value: currentPage)
                    .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                    .tabViewStyle(PageTabViewStyle())
                    .onChange(of: currentPage) { newValue in
                        selectedOne = newValue
                        withAnimation {
                            scrollToSelected = true
                        }
                    }
                    .padding(.bottom)
                   // Spacer()
                }
            }
            
        }
    }
    private func getView(for index: Int) -> some View {
        switch index {
        case 1:
            return AnyView(view1(index: index))
        case 2:
            return AnyView(view2(index: index))
        case 3:
            return AnyView(view3(index: index))
        case 4:
            return AnyView(view4(index: index))
        case 5:
            return AnyView(view5(index: index))
        default:
            return AnyView(view2(index: index))
        }
        
    }
}


#Preview {
  // HorizontalScrollViewLearning()
    YourDynamicList()
}


struct SubViewBox: View {
    public var number: Int
    var body: some View {
        VStack {
            Text("\(number)")
            Spacer()
            Text("\(number)")
        }
        .frame(width: 200, height: CGFloat(100 + (number * 400)))
        
    }
}


struct view1: View {
    public var index: Int
    var body: some View {
        VStack {
            Text("\(index)")
            Spacer()
            Text("\(index)")
        }
        .frame(width: 200, height: 300)
        .background(.green)
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}

struct view2: View {
    public var index: Int
    var body: some View {
        VStack {
            Text("\(index)")
            Spacer()
            Text("\(index)")
        }
        .frame(width: 200, height: 600)
        .background(.green)
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}


struct view3: View {
    public var index: Int
    var body: some View {
        VStack {
            Text("\(index)")
            Spacer()
            Text("\(index)")
        }
        .frame(width: 200, height: 900)
        .background(.green)
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}


struct view4: View {
    public var index: Int
    var body: some View {
        VStack {
            Text("\(index)")
            Spacer()
            Text("\(index)")
        }
        .frame(width: 200, height: 300)
        .background(.green)
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}

struct view5: View {
    public var index: Int
    var body: some View {
        VStack {
            Text("\(index)")
            Spacer()
            Text("\(index)")
        }
        .frame(width: 200, height: 500)
        .background(.green)
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}


struct ListView1: View {
    var body: some View {
        List(1...5, id: \.self) { index in
            Text("\(index)")
        }
    }
}

struct ContentView22: View {
        @State private var dynamicListHeight: CGFloat = 0

        var body: some View {
            VStack {
                YourDynamicList()
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .preference(key: ListHeightKey.self, value: geometry.size.height)
                        }
                    )
            }
            .onPreferenceChange(ListHeightKey.self) { height in
                self.dynamicListHeight = height
                print("YourDynamicList height: \(dynamicListHeight)")
            }
        }
    }

    struct YourDynamicList: View {
        @State public var height = 0.0
        var body: some View {
            List(1...23, id: \.self) { index in
                Text("\(index)")
                    .frame(height: 50)
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear(perform: {
                                    print(geometry.size.height)
                                })
                                .preference(key: ListHeightKey.self, value: geometry.size.height)
                        }
                    )
            }
            .onPreferenceChange(ListHeightKey.self) { height in
                self.height = height
                print("YourDynamicList height: \(height)")
            }
        }
    }

    struct ListHeightKey: PreferenceKey {
        static var defaultValue: CGFloat = 0

        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
