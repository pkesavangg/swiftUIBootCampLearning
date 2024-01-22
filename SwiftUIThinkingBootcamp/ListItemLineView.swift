//
//  ListItemLineView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 17/01/24.
//

import SwiftUI

struct ListItemView: View {
    public var quantity: String = "4 2/4 tablespoons"
    public var value: String = "Created by Kesavan Panchabakesan on 17/01/24."
    public var primaryIcon: String = "fork.knife"
    public var secondaryIcon: String = "cart.fill"
    let onClickPrimaryButton: (() -> Void)?
    let onClickSecondaryButton: (() -> Void)?

    var body: some View {
        VStack {
            HStack {
                HStack(alignment: .top, spacing: 4) {
                    Text("\(quantity)")
                        .foregroundColor(.blue)
                    Text("\(value)")
                }
                .multilineTextAlignment(.leading)
                .font(.body)
                .padding(.trailing, 8)

                Spacer()

                HStack {
                    Button(action: {
                        onClickPrimaryButton?()
                    }) {
                        Image(systemName: primaryIcon)
                            .foregroundColor(.red)
                            .padding(.trailing)
                    }

                    Button(action: {
                        onClickSecondaryButton?()
                    }) {
                        Image(systemName: secondaryIcon)
                            .foregroundColor(.red)
                    }
                }
            }
            .bottomBorder()
        }
        .padding(.vertical, 10)
    }
}


//#Preview {
//    MainListView()
//}

struct MainListView: View {
    @State var count = 1
    var body: some View {
        VStack {
            Button("Add") {
                count += 1
            }
            Button("Remove") {
                count -= 1
            }
            ForEach(1..<5) { val in
                ListItemView(value: "Created by Kesavan Created by Kesavan Panchabakesan on 17/01/24. \((3 + val) * count)", onClickPrimaryButton: {}, onClickSecondaryButton: {})
            }
        }
        
    }
}



struct BottomBorder: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.bottom, 6)
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .frame(width: geometry.size.width, height: 1)
                        .background(Color.black)
                        .offset(y: geometry.size.height)
                }
            )
    }
}

extension View {
    func bottomBorder() -> some View {
        self.modifier(BottomBorder())
    }
}


#Preview {
//    RecipeNutritionInfoView(nutrients: Nutrients)
RecipeNutritionInfoView2()
}


struct RecipeNutritionInfoView2: View {
    @State public var values = ["299 kcal", "25 g", "40 mg", "18 g", "10 g", "8 g", "721 mg", "4 g", "0 g" ]
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(spacing: 0){
                ForEach(values, id: \.self) { val in
                    HStack {
                        Text("Nutrients")
                        Spacer()
                        HStack {
                            Text(val ?? "")
                            Text("##%")
                                .padding(.leading, 20)
                        }
                    }
                   // .foregroundColor(index % 2 != 0 ? Color("color-black") : Color.black)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                  //  .background(index % 2 != 0 ? Color.gray.opacity(0.5) : Color.white)
                }
                
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 0.5)
            )
            .clipShape(.rect(cornerRadius: 10))
        }
    }
}
