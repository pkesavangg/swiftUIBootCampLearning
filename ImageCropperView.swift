//
//  ImageCropperView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 30/12/23.
//

import SwiftUI

import SwiftUI

public struct ImageCropperView2: View {

  let image: Image
  let ratio: CropperRatio2
  let cropRect: CGRect?
  
  var onCropChanged : ((CGRect) -> Void)?
  
  public init(image: Image,
              cropRect: CGRect? = nil,
              ratio: CropperRatio2) {
    self.image = image
    self.ratio = ratio
    self.cropRect = cropRect
  }
  
  public var body: some View {
    image
      .resizable()
      .scaledToFit()
      .overlay(
        GeometryReader { reader in
          CropperView2(viewModel: CropperViewModel2(parentProxy: reader,
                                                  cropRect: cropRect,
                                                  ratio: ratio,
                                                  onCropChanged: onCropChanged))
        }
      )
  }
}


// MARK: - Public API

extension ImageCropperView2 {
  
  public func onCropChanged(_ action: @escaping ((CGRect) -> Void)) -> Self {
    var copy = self
    copy.onCropChanged = action
    return copy
  }
}


struct TestingImageCroppingView: View {
    let ratio = CropperRatio2(width: 1, height: 1)
    var body: some View {
        
        ImageCropperView2(image: Image("Image1"), ratio: ratio).onCropChanged { (newCrop) in
            print(newCrop)
          }
    }
}

#Preview {
    TestingImageCroppingView()
//    let ratio = CropperRatio2(width: 1, height: 1)
//    ImageCropperView2(image: Image("Image1"), ratio: ratio)
        
}

//
//  CropperView.swift
//
//  Created by Anthony Fernandez on 17/12/2020.
//

import SwiftUI

struct CropperView2: View {
  
  @ObservedObject var viewModel: CropperViewModel2
  
  @State var cropCornerSize : CGFloat = 20
  @State var cropCornerWeight : CGFloat = 2
  
  var body: some View {
    ZStack {
      Rectangle()
        .fill(Color.black.opacity(0.3))
        .overlay(
          croppOverlay
        )
        .frame(width: viewModel.cropperRect.width, height: viewModel.cropperRect.height, alignment: .center)
        .position(x: viewModel.cropperRect.origin.x, y: viewModel.cropperRect.origin.y)
        .gesture(
          DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged({ newValue in
              viewModel.cropperRect.origin.x = max(viewModel.cropperRect.width / 2, min(newValue.location.x, viewModel.parentProxy.size.width - (viewModel.cropperRect.width / 2)))
              viewModel.cropperRect.origin.y = max(viewModel.cropperRect.height / 2, min(newValue.location.y, viewModel.parentProxy.size.height - (viewModel.cropperRect.height / 2)))
            })
            .onEnded({ (_) in
              viewModel.onCropChanged?(viewModel.cropViewToCropRect())
            })
        )
    }
    .frame(width: viewModel.parentProxy.size.width, height: viewModel.parentProxy.size.height, alignment: .center)
  }
  
  var croppOverlay : some View {
    VStack {
      HStack {
        VStack(alignment: .leading, spacing: 0) {
          Rectangle()
            .fill(Color.white)
            .frame(width: cropCornerSize, height: cropCornerWeight)
          HStack {
            Rectangle()
              .fill(Color.white)
              .frame(width: 2, height: cropCornerSize)
            Spacer()
          }
        }
        Spacer()
        VStack(alignment: .trailing, spacing: 0) {
          Rectangle()
            .fill(Color.white)
            .frame(width: cropCornerSize, height: cropCornerWeight)
          HStack {
            Spacer()
            Rectangle()
              .fill(Color.white)
              .frame(width: cropCornerWeight, height: cropCornerSize)
          }
        }
      }
      Spacer()
      HStack {
        VStack(alignment: .leading, spacing: 0) {
          HStack {
            Rectangle()
              .fill(Color.white)
              .frame(width: cropCornerWeight, height: cropCornerSize)
            Spacer()
          }
          Rectangle()
            .fill(Color.white)
            .frame(width: cropCornerSize, height: cropCornerWeight)
        }
        Spacer()
        VStack(alignment: .trailing, spacing: 0) {
          HStack {
            Spacer()
            Rectangle()
              .fill(Color.white)
              .frame(width: cropCornerWeight, height: cropCornerSize)
          }
          Rectangle()
            .fill(Color.white)
            .frame(width: cropCornerSize, height: cropCornerWeight)
        }
      }
    }
  }
}

final class CropperViewModel2: ObservableObject {
  
  @Published var parentProxy: GeometryProxy
  @Published var cropperRect: CGRect = .zero
  
  var ratio: CropperRatio2
  
  var onCropChanged : ((CGRect) -> Void)?
  
  init(parentProxy: GeometryProxy,
       cropRect: CGRect? = nil,
       ratio: CropperRatio2,
       onCropChanged : ((CGRect) -> Void)? = nil) {
    
    self.onCropChanged = onCropChanged
    self.parentProxy = parentProxy
    self.ratio = ratio
    
    if let cropRect = cropRect {
      self.cropperRect = cropRectToCropView(with: cropRect)
    }
    else {
      initializeCropRect()
    }
  }
  
  fileprivate func initializeCropRect() {
    cropperRect = createCropperFrame(for: parentProxy.size)
    
    // Save initial crop
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
      self.onCropChanged?(self.cropViewToCropRect())
    }
    
  }
  
  fileprivate func cropViewToCropRect() -> CGRect {
    
    let leftPos = (cropperRect.origin.x - (cropperRect.size.width / 2))
    let topPos = (cropperRect.origin.y - (cropperRect.size.height / 2))
    
    let x1 = leftPos / parentProxy.size.width
    let y1 = topPos / parentProxy.size.height
    let x2 = (leftPos + cropperRect.size.width) / parentProxy.size.width
    let y2 = (topPos + cropperRect.size.height) / parentProxy.size.height
    
    return CGRect(x: x1, y: y1, width: x2, height: y2)
  }
  
  fileprivate func cropRectToCropView(with cropRect: CGRect) -> CGRect {
    
    var x1 = parentProxy.size.width * cropRect.origin.x
    var y1 = parentProxy.size.height * cropRect.origin.y
    let x2 = (parentProxy.size.width * cropRect.size.width) - x1
    let y2 = (parentProxy.size.height * cropRect.size.height) - y1
    
    // View position modifies the center of it
    x1 += x2 / 2
    y1 += y2 / 2
    
    return CGRect(x: x1, y: y1, width: x2, height: y2)
  }
  
  fileprivate func createCropperFrame(for imageSize: CGSize) -> CGRect {
    let previewSize = CGSize(width: ratio.width, height: ratio.height)
    
    var height : CGFloat = 0
    var width : CGFloat = 0
    
    let printRatio = previewSize.width / previewSize.height
    let imageRatio = imageSize.width / imageSize.height
    
    if printRatio > imageRatio {
      height = imageSize.height
      width = (previewSize.width * height) / previewSize.height
      
      while width > imageSize.width {
        height -= 1
        width = (previewSize.width * height) / previewSize.height
      }
    }
    else {
      width = imageSize.width
      height = (previewSize.height * width) / previewSize.width
      
      while height > imageSize.height {
        width -= 1
        height = (previewSize.height * width) / previewSize.width
      }
    }
    
    let x = (imageSize.width / 2)
    let y = (imageSize.height / 2)
    
    return CGRect(x: x, y: y, width: width, height: height)
  }
}

import Foundation
import CoreGraphics

public struct CropperRatio2 {
  
  let width: CGFloat
  let height: CGFloat
  
  public init(width: CGFloat, height: CGFloat) {
    self.width = width
    self.height = height
  }
  
  public static var r_1_1: Self {
    return .init(width: 1, height: 1)
  }
  
  public static var r_3_2: Self {
    return .init(width: 3, height: 2)
  }
  
  public static var r_4_3: Self {
    return .init(width: 4, height: 3)
  }
  
  public static var r_16_9: Self {
    return .init(width: 16, height: 9)
  }
  
  static var r_18_6: Self {
    return .init(width: 18, height: 6)
  }
}
