//
//  ContentView.swift
//  BetterRest
//
//  Created by Gabriel Pereira on 25/03/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Property Wrappers
    @State private var wakeUp: Date = .now
    @State private var sleepAmount: Double = 8.0
    @State private var coffeeAmount: Int = 1
    
    // MARK: - UI Components
    var body: some View {
        NavigationView {
            VStack {
                Text("When do you want to wake up?")
                    .font(.headline)
                
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                
                Text("Desired amount of sleep")
                    .font(.headline)
                
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                
                Text("Daily coffee intake")
                    .font(.headline)
                
                Stepper("\(coffeeAmount) \(coffeeAmount == 1 ? "cup" : "cups")", value: $coffeeAmount, in: 1...20)
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedTime)
            }
        }
    }
    
    // MARK: - Public and Internal Methods
    func calculateBedTime() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
