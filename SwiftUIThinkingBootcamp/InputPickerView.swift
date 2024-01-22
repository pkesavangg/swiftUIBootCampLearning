//
//  InputPickerView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 27/12/23.
//

import SwiftUI
import Foundation

struct InputPickerView: View {
    @State private var selectedHour: Int? = 54
    @State private var selectedMinute: Int? = 32
     
    var body: some View {
        VStack(alignment: .leading) {
            Text("Cooking Time")
                .fontWeight(.semibold)
                PickerTextField(firstComponentData: [""] + Array(1...100).map {  $0 == 1 ? "\($0) hour" : "\($0) hours" },
                                secondComponentData: [""] + Array(1...59).map { $0 == 1 ? "\($0) minute" : "\($0) minutes" },
                                placeholder: "",
                                firstComponentSelectedIndex: $selectedHour,
                                secondComponentSelectedIndex: $selectedMinute)
                .padding(.horizontal)
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 3)
            )
        }
        .onAppear {
            // Set the initial selected indices
            DispatchQueue.main.async {
                selectedHour = 54
                selectedMinute = 32
            }
        }
        .padding(.horizontal)
    }
}

struct PickerTextField: UIViewRepresentable {
    private let textField = UITextField()
    private let pickerView = UIPickerView()
    private let helper = Helper()
    
    var firstComponentData: [String]
    var secondComponentData: [String]? = nil
    var placeholder: String
    @Binding var firstComponentSelectedIndex: Int?
    @Binding var secondComponentSelectedIndex: Int?
    
    func makeUIView(context: Context) -> UITextField {
        self.pickerView.delegate = context.coordinator
        self.pickerView.dataSource = context.coordinator
        
        self.textField.placeholder = self.placeholder
        self.textField.inputView = self.pickerView
        
        //Configure Toolbar view
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Place "Cancel" button on the left
        let cancelButton = UIBarButtonItem(title: "Clear", style: .plain, target: self.helper, action: #selector(self.helper.cancelButtonAction))
        
        // Add flexible space to push the "Done" button to the right
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // Place "Done" button on the right
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self.helper, action: #selector(self.helper.doneButtonAction))
        
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: true)
        self.textField.inputAccessoryView = toolbar
        
        self.helper.doneButtonClicked = {
            if self.firstComponentSelectedIndex == nil {
                self.firstComponentSelectedIndex = 0
            }
            
            if self.secondComponentSelectedIndex == nil {
                self.secondComponentSelectedIndex = 0
            }
            self.textField.resignFirstResponder()
        }
        
        self.helper.clearButtonClicked = {
            self.secondComponentSelectedIndex = 0
            self.firstComponentSelectedIndex = 0
        }
        
        return textField
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(firstComponentData: firstComponentData, secondComponentData: secondComponentData) { hourIndex, minuteIndex in
            // Handle the selected hour and minute indices here
            // For example:
            self.firstComponentSelectedIndex = Int(hourIndex)
            self.secondComponentSelectedIndex = Int(minuteIndex)
        }
    }
    
    class Helper {
        public var doneButtonClicked: (() -> Void)?
        public var clearButtonClicked: (() -> Void)?
        
        @objc func doneButtonAction() {
            self.doneButtonClicked?()
        }
        
        @objc func cancelButtonAction() {
            self.clearButtonClicked?()
        }
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        print(" \(self.firstComponentData[firstComponentSelectedIndex ?? 0])", "updateUIView")
        if (firstComponentSelectedIndex == nil || firstComponentSelectedIndex == 0) &&
            (secondComponentSelectedIndex == nil || secondComponentSelectedIndex == 0) {
            uiView.text = ""
            return
        }
        
        uiView.text = " \(self.firstComponentData[firstComponentSelectedIndex ?? 0])"
        if let secondComponentData = self.secondComponentData {
            uiView.text = " \(self.firstComponentData[firstComponentSelectedIndex ?? 0]) \(secondComponentData[secondComponentSelectedIndex ?? 0])"
        }
        pickerView.selectRow(firstComponentSelectedIndex ?? 0, inComponent: 0, animated: true)
           pickerView.selectRow(secondComponentSelectedIndex ?? 0, inComponent: 1, animated: true)
    }
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        private var firstComponentData: [String]
        private var secondComponentData: [String]?
        private var didSelect: ((Int, Int) -> Void)?
        
        init(firstComponentData: [String], secondComponentData: [String]?, didSelect: ((Int, Int) -> Void)? = nil) {
            self.firstComponentData = firstComponentData
            self.secondComponentData = secondComponentData
            self.didSelect = didSelect
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return (secondComponentData != nil) ? 2 : 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            switch component {
            case 0:
                return firstComponentData.count
            case 1:
                return secondComponentData?.count ?? 0
            default:
                return 0
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return component == 0 ? firstComponentData[row] : secondComponentData?[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let selectedHourIndex = pickerView.selectedRow(inComponent: 0)
            let selectedMinuteIndex = (secondComponentData != nil) ? pickerView.selectedRow(inComponent: 1) : 0
            didSelect?(selectedHourIndex, selectedMinuteIndex)
        }
    }
}

#Preview {
    InputPickerView()
}
