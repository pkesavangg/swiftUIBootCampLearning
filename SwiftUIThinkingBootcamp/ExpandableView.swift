//
//  ExpandableView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 20/01/24.
//

import SwiftUI

struct ExpandableView: View {
    var body: some View {
        VStack {
          //  ZStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        VStack {
                            HStack(alignment: .top) {
                                    Text("\(2 + 1).")
                                        .fontWeight(.semibold)
                                       
                                    if true {
                                        Text("\("content.title")")
                                            .fontWeight(.semibold)
                                    } else {
                                        Text("\("content.description")")
                                            .multilineTextAlignment(.leading)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .font(.body)
                                    }
                                Spacer()
                            }
                            .padding()
                            .padding(.top)
                            HStack {
                                if true {
                                    Text("\("content.description content.descriptioncontent.descriptioncontent.descriptioncontent.description")")
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .font(.body)
                                       // .padding(.trailing, 8)
                                        .padding(.leading, 40)
                                }
                                   
                                Spacer()
                            }
                            
                            Spacer()
                        }
                        Spacer()
                    }
                }
               // .frame(minHeight: 40)
                .frame(maxWidth: .infinity)
            //}
            VStack {
                HStack(spacing: 30) {
                    Spacer()
                    Button(action: {
                      //  onEdit?()
                    }) {
                        Image(systemName: "pencil")
                            .foregroundColor(Color("AccentColor"))
                    }
                    Button(action: {
                      //  onRemove?()
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(Color("AccentColor"))
                    }
                }
                .padding([.horizontal, .bottom])
            }
        }
    
        .background(Color.gray.opacity(0.3))
        .clipShape(.rect(cornerRadius: 10))
        .padding(.vertical, 0)
    }
}

#Preview {
    ForEach(0..<5) { index in
        ExpandableView()
    }
    
}
