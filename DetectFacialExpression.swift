//
//  DetectFacialExpression.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 16/01/24.
//

import SwiftUI
import Foundation
import ARKit
import Combine
import UIKit

var facialExpressionEventsSubject: PassthroughSubject = PassthroughSubject<FacialExpression, Never>();

class DetectFacialExpressionViewModel: ObservableObject {
    @Published public var pageIndex = 0
    
    @Published public var facialExpression: FacialExpression?
    public var indices = [0,1,2,3,4]
    private var cancellables: Set<AnyCancellable> = []
    init() {
        facialExpressionEventsSubject
            .receive(on: DispatchQueue.main)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.facialExpression = value
                    if let text = FacialExpression(rawValue: value.rawValue).text {
                        print(text, "facialExpressionEventsSubject")
                        
                        if text == "Eye Blink Left" {
                            if self.pageIndex > 0 {
                                self.pageIndex -= 1
                            }
                        } else if text == "Eye Blink Right" {
                            if self.pageIndex < (self.indices.count - 1) {
                                self.pageIndex += 1
                            }
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }
}

struct DetectFacialExpression: View {
    @StateObject private var viewModel = DetectFacialExpressionViewModel()
    private let dotAppearance = UIPageControl.appearance()
    @State private var isHandsFreeModeOn: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                TabView(selection: $viewModel.pageIndex) {
                    ForEach(viewModel.indices, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Step: \(index + 1)")
                                    .opacity(0.6)
                                    .padding(.bottom)
                                switch(index + 1) {
                                case 1:
                                    Text("Heat the oven to 190C/170C fan/gas 5. ")
                                case 2:
                                    Text("Roll the dough into walnut-sized balls ")
                                case 3:
                                    Text("baking soda, and salt. Gradually add ")
                                case 4:
                                    Text("In a separate bowl, whisk together the ")
                                case 5:
                                    Text("Lorem ipsum dolor sit amet, consectetur ")
                                default:
                                    Text("")
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                        .frame(height: 300)
                        .padding()
                        .tag(index)
                    }
                }
                .animation(.easeInOut, value: viewModel.pageIndex)// 2
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .tabViewStyle(PageTabViewStyle())
                .onAppear {
                    dotAppearance.currentPageIndicatorTintColor = .black
                    dotAppearance.pageIndicatorTintColor = .gray
                }
                .overlay(content: {
                    if isHandsFreeModeOn {
                        ARView()
                            .frame(width: 10, height: 10)
                            .cornerRadius(15)
                            .opacity(0)
                    }
                })
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            self.isHandsFreeModeOn.toggle()
                        } label: {
                            Image(systemName: isHandsFreeModeOn ? "eye" : "eye.slash")
                                .font(.callout)
                        }
                        
                    }
                })
                Spacer()
            }
        }
    }
}

struct ARView: UIViewControllerRepresentable {
    typealias UIViewControllerType = ARViewController
    
    func makeUIViewController(context: Context) -> ARViewController {
        let viewController = ARViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
        // Update the view controller if needed
    }
}

class ARViewController: UIViewController, ARSCNViewDelegate {
    var sceneView: ARSCNView!
    public var analyzers = DefaultFacialExpressionAnalyzersProvider().defaultFacialExpressionAnalyzers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupARSceneView()
    }
    
    
    private func setupARSceneView() {
        sceneView = ARSCNView()
        view.addSubview(sceneView)
        adjustSceneViewConstraints()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true // Enable debug mode
        
        let configuration = ARFaceTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    private func adjustSceneViewConstraints() {
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.leftAnchor.constraint(equalTo: view.leftAnchor),
            sceneView.rightAnchor.constraint(equalTo: view.rightAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARFaceTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let faceMesh = ARSCNFaceGeometry(device: sceneView.device!)
        let node = SCNNode(geometry: faceMesh)
        
        // Customize the node if needed, e.g., for debug mode
        if sceneView.showsStatistics {
            node.geometry?.firstMaterial?.fillMode = .lines
        }
        
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
            return
        }
        
        faceGeometry.update(from: faceAnchor.geometry)
        let _: [FacialExpression] = analyzers.compactMap {
            let blendShape = faceAnchor.blendShapes[$0.blendShapeLocation]
            if let value = blendShape?.decimalValue ?? 0.0 > $0.minimumValidCoefficient ? $0.facialExpression : nil {
                facialExpressionEventsSubject.send(value)
            }
            return blendShape?.decimalValue ?? 0.0 > $0.minimumValidCoefficient ? $0.facialExpression : nil
        }
        
    }
}

extension FacialExpression: Hashable {
    var text: String? {
        let expressionsMap: [FacialExpression: String] = [
            .eyeBlinkLeft: "Eye Blink Left",
            .eyeBlinkRight: "Eye Blink Right",
        ]
        return expressionsMap[self]
    }
}

public struct FacialExpression: RawRepresentable, Equatable {
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public typealias RawValue = String
    
    public static let eyeBlinkLeft =  FacialExpression(rawValue: "eyeBlinkLeft")
    public static let eyeBlinkRight =  FacialExpression(rawValue: "eyeBlinkRight")
    
}

public struct FacialExpressionAnalyzer: Equatable {
    public let facialExpression: FacialExpression
    let blendShapeLocation: ARFaceAnchor.BlendShapeLocation
    let minimumValidCoefficient: Decimal
    
    public init(facialExpression: FacialExpression,
                blendShapeLocation: ARFaceAnchor.BlendShapeLocation,
                minimumValidCoefficient: Decimal = 0.5) {
        self.facialExpression = facialExpression
        self.blendShapeLocation = blendShapeLocation
        self.minimumValidCoefficient = minimumValidCoefficient
    }
}

final class DefaultFacialExpressionAnalyzersProvider {
    func defaultFacialExpressionAnalyzers() -> [FacialExpressionAnalyzer] {
        [
            FacialExpressionAnalyzer(facialExpression: FacialExpression.eyeBlinkLeft, blendShapeLocation: .eyeBlinkRight),
            FacialExpressionAnalyzer(facialExpression: FacialExpression.eyeBlinkRight, blendShapeLocation: .eyeBlinkLeft)]
        
    }
}


#Preview {
    DetectFacialExpression()
}



