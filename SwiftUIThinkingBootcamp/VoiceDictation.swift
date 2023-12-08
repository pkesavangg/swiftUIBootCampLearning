////
////  VoiceDictation.swift
////  SwiftUIThinkingBootcamp
////
////  Created by Kesavan Panchabakesan on 24/11/23.
////
//
//import SwiftUI
//import Speech
//
//struct VoiceDictation: View {
//    @State private var searchText: String = ""
//       @State private var isRecording: Bool = false
//       @State private var recognizedText: String = ""
//       @State private var isSpeechAvailable = false
//
//       var body: some View {
//           VStack {
//               TextField("Search", text: $searchText)
//                   .textFieldStyle(RoundedBorderTextFieldStyle())
//                   .padding()
//
//               if isSpeechAvailable {
//                   Button(action: {
//                       if isRecording {
//                           stopRecording()
//                       } else {
//                           startRecording()
//                       }
//                   }) {
//                       Image(systemName: isRecording ? "stop.circle.fill" : "mic.circle.fill")
//                           .resizable()
//                           .aspectRatio(contentMode: .fit)
//                           .frame(width: 50, height: 50)
//                           .padding()
//                   }
//
//                   Text("Spoken Text: \(recognizedText)")
//                       .padding()
//               } else {
//                   Text("Speech Recognition not available on this device")
//                       .foregroundColor(.red)
//                       .padding()
//               }
//           }
//           .onAppear {
//               checkSpeechAvailability()
//           }
//       }
//
//       func startRecording() {
//           do {
//               let recognizer = try SFSpeechRecognizer()
//               if !(recognizer?.isAvailable ?? false) {
//                   print("Speech recognition is not available on this device.")
//                   return
//               }
//
//               let audioSession = AVAudioSession.sharedInstance()
//               try audioSession.setCategory(.record, mode: .default, options: [])
//               try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
//
//               let request = SFSpeechAudioBufferRecognitionRequest()
//
//               SpeechManager.shared.startRecording(request: request) { result in
//                   switch result {
//                   case .success(let recognizedText):
//                       self.recognizedText = recognizedText
//                       self.searchText = recognizedText
//                   case .failure(let error):
//                       print("Speech recognition failed with error: \(error)")
//                   }
//               }
//
//               isRecording = true
//           } catch {
//               print("Error starting speech recognition: \(error.localizedDescription)")
//           }
//       }
//
//       func stopRecording() {
//           SpeechManager.shared.stopRecording()
//           isRecording = false
//       }
//
//    func checkSpeechAvailability() {
//        let recognizer = SFSpeechRecognizer()
//        isSpeechAvailable = recognizer?.isAvailable ?? false
//    }
//}
//
//#Preview {
//    VoiceDictation()
//}
//
//
//import Foundation
//import Speech
//
//class SpeechManager {
//    static let shared = SpeechManager()
//    private var audioEngine: AVAudioEngine?
//    private var recognitionTask: SFSpeechRecognitionTask?
//
//    private init() {}
//
//    func startRecording(request: SFSpeechAudioBufferRecognitionRequest, completion: @escaping (Result<String, Error>) -> Void) {
//        guard let recognizer = SFSpeechRecognizer() else {
//            completion(.failure(NSError(domain: "SpeechRecognition", code: 1, userInfo: [NSLocalizedDescriptionKey: "Speech recognizer is not available"])))
//            return
//        }
//
//        if !recognizer.isAvailable {
//            completion(.failure(NSError(domain: "SpeechRecognition", code: 1, userInfo: [NSLocalizedDescriptionKey: "Speech recognizer is not available"])))
//            return
//        }
//
//        do {
//            audioEngine = AVAudioEngine()
//
//            guard let audioEngine = audioEngine else {
//                completion(.failure(NSError(domain: "SpeechRecognition", code: 2, userInfo: [NSLocalizedDescriptionKey: "Audio engine not available"])))
//                return
//            }
//
//            let node = audioEngine.inputNode
//            let recordingFormat = node.outputFormat(forBus: 0)
//            node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
//                request.append(buffer)
//            }
//
//            audioEngine.prepare()
//            try audioEngine.start()
//
//            recognitionTask = recognizer.recognitionTask(with: request) { result, error in
//                if let result = result {
//                    let recognizedText = result.bestTranscription.formattedString
//                    completion(.success(recognizedText))
//                } else if let error = error {
//                    completion(.failure(error))
//                }
//            }
//        } catch {
//            completion(.failure(error))
//        }
//    }
//
//    func stopRecording() {
//        audioEngine?.stop()
//        audioEngine?.inputNode.removeTap(onBus: 0)
//        recognitionTask?.cancel()
//    }
//}
//
//


//import SwiftUI
//import Speech
//
//struct VoiceDictation: View {
//
//    let countries = ["USA", "Canada", "UK", "Germany", "France", "Australia", "Japan", "India", "China"]
//
//    @State private var searchText = ""
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(filteredCountries, id: \.self) { country in
//                    Text(country)
//                }
//            }
//            .searchable(text: $searchText) {
//                ForEach(filteredCountries, id: \.self) { country in
//                    Text(country)
//                }
//
//            }
//            .navigationTitle("Countries")
//        }
//    }
//
//    var filteredCountries: [String] {
//        if searchText.isEmpty {
//            return countries
//        } else {
//            return countries.filter { $0.localizedCaseInsensitiveContains(searchText) }
//        }
//    }
//
//}
//struct VoiceDictation_Previews: PreviewProvider {
//    static var previews: some View {
//        VoiceDictation()
//    }
//}
import SwiftUI
import Speech

struct VoiceDictation: View {
    
    let countries = ["Apple Juice", "USA", "Canada", "UK", "Germany", "France", "Australia", "Japan", "India", "China"]
    
    @State private var searchText = ""
    @State private var isRecording = false
    @State private var recognizedText = "sample"
    
    var body: some View {
        NavigationView {
           
            List {
                ForEach(filteredCountries, id: \.self) { country in
                    Text(country)
                }
                Text(recognizedText)
                
            }
            .searchable(text: $searchText) {
                ForEach(filteredCountries, id: \.self) { country in
                    Text(country)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isRecording.toggle()
                        if isRecording {
                            startRecording()
                        } else{
                            stopRecording()
                        }
                        
                        
                    }) {
                        Image(systemName: isRecording ? "stop.circle.fill" : "mic.circle.fill")
                            .imageScale(.large)
                    }
                }

            }
            .onChange(of: recognizedText) { newText in
                searchText = newText
            }
            .onDisappear {
                stopRecording()
            }
            .navigationTitle("Countries")
            
        }
    }
    
    var filteredCountries: [String] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func startRecording() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == .authorized {
                
                let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
                let request = SFSpeechAudioBufferRecognitionRequest()
                request.taskHint = .dictation
                recognizer?.recognitionTask(with: request) { (result, error) in
                    guard let result = result else {
                        print("There was an error: \(error!)")
                        return
                    }
                    
                    if result != nil {
                        let recognizedText = result.bestTranscription.formattedString
                        self.recognizedText =  recognizedText
                        print("Recognized Text: \(result.bestTranscription.formattedString)")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            stopRecording()
                        }
                        
                    }
                }
                
               
                do {
                    let audioSession = AVAudioSession.sharedInstance()
                    try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
                    try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                    
                    let inputNode = audioEngine.inputNode
                    let recordingFormat = inputNode.outputFormat(forBus: 0)
                    
                    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, time) in
                        request.append(buffer)
                        print("Received audio buffer\(buffer) \(time)")
                    }
                    audioEngine.prepare()
                    try audioEngine.start()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        stopRecording()
                    }
                } catch {
                    print("Error setting up audio session or starting recording: \(error)")
                }
            }
        }
    }
    
    func stopRecording() {
        self.isRecording = false
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
    }
    
    private let audioEngine = AVAudioEngine()
    
}

struct DraggableButton_Previews: PreviewProvider {
    static var previews: some View {
        DraggableButton()
    }
}
//
//  DraggableButton.swift
//  Drag and Stick Floating Button
//
//  Created by Swee Kwang Chua on 28/12/22.
//

import SwiftUI

struct DraggableButton: View {
    @State private var dragAmount: CGPoint?
    @State var opacityState: Double = 1
    @State private var showModal = false;
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            Color.white.opacity(0.3)
                .onTapGesture {
                    withAnimation {
                        self.showModal.toggle()
                    }
                }
            GeometryReader { geometry in
                HStack {
                    VStack {
                        Spacer()
                        Image(systemName: "mic.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.gray)
                            .onTapGesture {
                                withAnimation {
                                    self.showModal.toggle()
                                }
                               
                            }
                            .opacity(opacityState)
                            .onLongPressGesture(minimumDuration: 0.2) {
                                print("press")
                                withAnimation(.linear(duration: 0.1)) {
                                    opacityState = 0.2
                                }
                                
                                withAnimation(.linear(duration: 0.1).delay(0.1)) {
                                    opacityState = 1
                                }
                                
                            }
                            .frame(width: 50, height: 50)
                            .padding(0)
                            .position(dragAmount ?? CGPoint(x: geometry.size.width-34, y: geometry.size.height-100))
                            .gesture(
                                DragGesture()
                                    .onChanged { self.dragAmount = $0.location }
                                    .onEnded { value in
                                        var currentPostion = value.location
                                        
                                        if currentPostion.x > (geometry.size.width/2) {
                                            currentPostion.x = geometry.size.width - 34
                                        } else {
                                            currentPostion.x =  34
                                        }
                                        
                                        if currentPostion.y > (geometry.size.height/2) {
                                            currentPostion.y = geometry.size.height - 34 - 40
                                        } else {
                                            currentPostion.y =  74
                                        }
                                        
                                        withAnimation(.easeOut(duration: 0.05)) {
                                            dragAmount = currentPostion
                                        }
                                    }
                            )
                        
                        if showModal {
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .fill(Color.white)
                                .frame(height: UIScreen.main.bounds.height * 0.3)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .transition(.move(edge: .bottom))
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                .overlay {
                                    VStack(spacing: 10, content: {
                                        Text("Hi, I'm listening. Try saying..")
                                            .font(.footnote)
                                        Text("Apple juice")
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        Image(systemName: "mic.circle.fill")
                                            .font(.largeTitle)
                                            .foregroundColor(.orange)
                                            .padding(.top)
                                    })
                                }
                        }
                    }
                }
            }
            
        })
        .ignoresSafeArea(.all)
    }
}

//struct DraggableButton_Previews: PreviewProvider {
//    static var previews: some View {
//        DraggableButton()
//    }
//}

//
//  ChatButton.swift
//  Drag and Stick Floating Button
//
//  Created by Swee Kwang Chua on 28/12/22.
//

//import SwiftUI
//
//struct ChatButton: View {
//    
//    @State var opacityState: Double = 1
//    
//    var body: some View {
//        
//    }
//}

//struct ChatButton_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatButton()
//    }
//}
