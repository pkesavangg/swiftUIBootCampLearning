//
//  SlideShowBootCampLearning.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 30/12/23.
//

import SwiftUI

struct SlideShowVideoView: View {
    @State private var pageIndex = 0
    private let dotAppearance = UIPageControl.appearance()
    public var homePageImageUrls = ["https://s3.amazonaws.com/gg-mark/gsg/variation/4VuVwHTDaqmeDiz8WoUUVp.jpg",
                                    "https://s3.amazonaws.com/gg-mark/gsg/variation/4VuVwHTDaqmeDiz8WoUUVp.jpg",
                                    "https://s3.amazonaws.com/gg-mark/gsg/variation/4VuVwHTDaqmeDiz8WoUUVp.jpg",
                                    "https://s3.amazonaws.com/gg-mark/gsg/variation/4VuVwHTDaqmeDiz8WoUUVp.jpg"
    ]
    var body: some View {
        VStack {
            TabView(selection: $pageIndex) {
                ForEach(homePageImageUrls.indices) { index in
                    VStack {
                        Spacer()
                        AsyncImage(url: URL(string: homePageImageUrls[index])) { image in
                                   image
                                       .resizable()
                                       .aspectRatio(contentMode: .fill)
                                       .cornerRadius(10)
                                       
                               } placeholder: {
                                   ProgressView()
                               }
                               .frame(width: 250, height: 250)
                       // PageView(page: page)
                        Spacer()
                    }
                    .tag(index)
                }
            }
            .animation(.easeInOut, value: pageIndex)// 2
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .tabViewStyle(PageTabViewStyle())
            .onAppear {
                dotAppearance.currentPageIndicatorTintColor = .black
                dotAppearance.pageIndicatorTintColor = .gray
            }
        }

    }
}

#Preview {
    SlideShowVideoView()
}

import AVKit
import SwiftUI

struct VideosTabView: View {
    var player = AVPlayer(url: URL(string: "https://embed-ssl.wistia.com/deliveries/cc8402e8c16cc8f36d3f63bd29eb82f99f4b5f88/accudvh5jy.mp4")!)
    
    var body: some View {
        ZStack  {
            
        }
        VideoPlayer(player: player) {
            VStack {
                Text("Watermark")
                    .foregroundStyle(.black)
                    .background(.white.opacity(0.7))
                Spacer()
            }
            .frame(width: 400, height: 300)
        }
        .frame(height: 300, alignment: .center)
        .cornerRadius(10)
        .padding(.horizontal)
        .onAppear {
            player.play()
            self.player.isMuted = true
        }
        .onDisappear {
            player.pause()
        }
    }
}

//#Preview {
//    VideosTabView()
//}

import Foundation

struct Page: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var imageUrl: String
    var tag: Int
    
    static var samplePage = Page(name: "Title Example", description: "This is a sample description for the purpose of debugging", imageUrl: "work", tag: 0)
    
    static var samplePages: [Page] = [
        Page(name: "Welcome to Default App!", description: "The best app to get stuff done on an app.", imageUrl: "cowork", tag: 0),
        Page(name: "Meet new people!", description: "The perfect place to meet new people so you can meet new people!", imageUrl: "work", tag: 1),
        Page(name: "Edit your face", description: "Don't like your face? Well then edit your face with our edit-face tool!", imageUrl: "website", tag: 2),
    ]
}


struct PageView: View {
    var page: Page
    
    var body: some View {
        VStack(spacing: 10) {
            Image("\(page.imageUrl)")
                .resizable()
                .scaledToFit()
                .padding()
                .cornerRadius(30)
                .background(.gray.opacity(0.10))
                .cornerRadius(10)
                .padding()
        }
    }
}
