//
//  DatepickerBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 05/11/23.
//

import SwiftUI

struct DatepickerBootcamp: View {
    
    @State private var selectedDate = Date()
    let startingDate: Date = Calendar.current.date(from: DateComponents(year: 2018)) ?? Date()
    let endingDate: Date = Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Selected date is ")
                Text(dateFormatter.string(from: selectedDate))
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
            
            DatePicker("Select a date: ",
                       selection: $selectedDate,
                       in: startingDate...endingDate,
                       displayedComponents: [.date, .hourAndMinute])
            .accentColor(.yellow)
            .datePickerStyle(CompactDatePickerStyle())
            //.datePickerStyle(WheelDatePickerStyle())
            //.datePickerStyle(GraphicalDatePickerStyle())
        }
    }
}

#Preview {
    DatepickerBootcamp()
}
