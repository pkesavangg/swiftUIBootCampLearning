//
//  ReadBarCodeView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 14/12/23.
//

import SwiftUI

import SwiftUI
import AVFoundation

struct QRCodeScannerView: View {
    @State private var scannedCode: String? = "NO SCANNED VALUE"
    @State private var openQRScan: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                if let scannedCode = scannedCode {
                    HStack {
                        Group {
                            Text("Scanned QR value:")
                            
                            Text(scannedCode)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .fontWeight(.semibold)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.vertical)
                }
                
                Spacer()
            }
            .toolbar( content: {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        openQRScan = true
                    }, label: {
                        HStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 60, height: 60)
                                .overlay {
                                    Image(systemName: "qrcode.viewfinder")
                                        .fontWeight(.bold)
                                        .font(.title2)
                                        .foregroundColor(.white)
                                }
                            
                        }
                        
                    })
                    .padding()
                }
            })
            .sheet(isPresented: $openQRScan, content: {
                CameraView(openQRScan: $openQRScan, scannedCode: $scannedCode)
            })
            .navigationTitle("QR Code Scanner")
        }
    }
}


struct CameraView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding public var openQRScan: Bool
    @Binding public var scannedCode: String?
    var body: some View {
        ZStack {
            Color.white.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            VStack {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Your simulated QR code data") { result in
                    switch result {
                    case .success(let code):
                        
                        withAnimation {
                            self.scannedCode = code
                            openQRScan = false
                        }
                        break
                    case .failure(let error):
                        print("Scanning failed with error: \(error.localizedDescription)")
                    }
                }
            }
//            .frame(width: 250, height: 250)
//            .cornerRadius(10)
//            .clipShape(Rectangle())
//            .overlay(
//                 RoundedRectangle(cornerRadius: 10)
//                     .stroke(Color.blue, style: StrokeStyle(lineWidth: 5.0,lineCap: .round, lineJoin: .bevel, dash: [60, 65], dashPhase: 29))
//             )
            VStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 100, height: 5)
                    .offset(y: -(UIScreen.main.bounds.height / 3) - 60 )
                HStack {
                    Text("Scan Any QR Code")
                        .foregroundColor(.blue)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    
                    Button(action: {
                        withAnimation {
                            openQRScan = false
                        }
                        
                    }, label: {
                        
                        Image(systemName: "xmark.circle")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.blue)
                        
                    })
                    .offset(x: (UIScreen.main.bounds.width / 2 ) - 130 )
                }
                .offset(y: -(UIScreen.main.bounds.height / 3) - 50 )
            }
        }
    }
}

struct QRCodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScannerView()
    }
}

struct CodeScannerView: UIViewControllerRepresentable {
    var codeTypes: [AVMetadataObject.ObjectType]
    var simulatedData: String?
    var didFindCode: (Result<String, Error>) -> Void
    
    func makeUIViewController(context: Context) -> UIViewController {
        var viewController = UIViewController()
        let scannerViewController = ScannerViewController()
        scannerViewController.delegate = context.coordinator
        scannerViewController.codeTypes = codeTypes
        scannerViewController.simulatedData = simulatedData
        viewController = scannerViewController
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(didFindCode: didFindCode)
    }
    
    class Coordinator: NSObject, ScannerViewControllerDelegate {
        var didFindCode: (Result<String, Error>) -> Void
        
        init(didFindCode: @escaping (Result<String, Error>) -> Void) {
            self.didFindCode = didFindCode
        }
        
        func didFindCode(_ code: String) {
            didFindCode(.success(code))
        }
        
        func didFailWithError(_ error: Error) {
            didFindCode(.failure(error))
        }
    }
}

protocol ScannerViewControllerDelegate: AnyObject {
    func didFindCode(_ code: String)
    func didFailWithError(_ error: Error)
}

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    weak var delegate: ScannerViewControllerDelegate?
    var codeTypes: [AVMetadataObject.ObjectType] = [.qr]
    var simulatedData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Did Load")
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: captureDevice)
        } catch {
            delegate?.didFailWithError(error)
            return
        }
        
        let session = AVCaptureSession()
        
        if (session.canAddInput(videoInput)) {
            session.addInput(videoInput)
        } else {
            delegate?.didFailWithError(ScannerError.inputUnavailable)
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (session.canAddOutput(metadataOutput)) {
            session.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = codeTypes
            
        } else {
            delegate?.didFailWithError(ScannerError.outputUnavailable)
            return
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async {
            session.startRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let metadataObject = metadataObjects.first else { return }
        
        guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
        
        guard let stringValue = readableObject.stringValue else { return }
        
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        foundCode(stringValue)
    }
    
    private func foundCode(_ code: String) {
        delegate?.didFindCode(code)
    }
}

enum ScannerError: Error {
    case inputUnavailable
    case outputUnavailable
}

