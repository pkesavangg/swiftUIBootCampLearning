//
//  FlexibleDirectionBox.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 11/01/24.
//

import SwiftUI

struct FlexibleDirectionBox: View {
    @State var value: String = "sdfnkfjndjksfndjksg"
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ZStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        HStack {
                            VStack {
                                HStack(alignment: .top) {
                                        Text("\(2 + 1).")
                                            .fontWeight(.semibold)
                                        if true {
                                            Text("\("content.title content.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.titlecontent.title")")
                                                .fontWeight(.semibold)
                                            
                                        }
                                    Spacer()
                                }
                                .padding()
//                                HStack {
//                                        Text("\("content.description")")
//                                            .padding(.leading, 40)
//                                    Spacer()
//                                }
                                
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    .frame(minHeight: 40)
                    .frame(maxWidth: .infinity)
                }
                VStack {
                    HStack(spacing: 30) {
                        Spacer()
                        Button(action: {
                        }) {
                            Image(systemName: "pencil")
                                .foregroundColor(Color("AccentColor"))
                        }
                        Button(action: {
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
            .padding(.vertical, 6)
        }   
        .padding()
    }
    private func getHeightForIndex(_ value: String) -> CGFloat {
        let height = value.height(withConstrainedWidth: UIScreen.main.bounds.width - 40, font: UIFont.systemFont(ofSize: 17))
        return max(40, height + 30)
    }
}



#Preview {
    DirectionRow()
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}


struct DirectionRow: View {
    var body: some View {
        ScrollView(.vertical) {
            ForEach(0...3, id: \.self) { index in
                ExtractedView23()
                
            }
        }
        
    }
}

struct ExtractedView23: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ZStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        HStack {
                            VStack {
                                HStack(alignment: .top) {
                                    Text("\(2 + 1).")
                                        .fontWeight(.semibold)
                                    if false {
                                        Text("\("content.title")")
                                            .fontWeight(.semibold)
                                    } else {
                                        Text("\("content.description")")
                                    }
                                    Spacer()
                                }
                                .padding()
                                HStack {
                                    if false {
                                        Text("\("content.description")")
                                            .padding(.leading, 40)
                                    }
                                       
                                    Spacer()
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    .frame(minHeight: 20)
                    .frame(maxWidth: .infinity)
                }
            }
            // .background(Color.gray.opacity(0.3))
            .clipShape(.rect(cornerRadius: 10))
            .padding(.vertical, 6)
        }
    }
}
