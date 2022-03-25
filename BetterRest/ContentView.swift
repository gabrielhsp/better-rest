//
//  ContentView.swift
//  BetterRest
//
//  Created by Gabriel Pereira on 25/03/22.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount: Double = 8.0
    @State private var wakeUp: Date = .now
    
    var body: some View {
        VStack {
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
            
            DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
                .labelsHidden()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
