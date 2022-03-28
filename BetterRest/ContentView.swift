//
//  ContentView.swift
//  BetterRest
//
//  Created by Gabriel Pereira on 25/03/22.
//

import CoreML
import SwiftUI

struct ContentView: View {
    // MARK: - Property Wrappers
    @State private var wakeUp: Date = defaultWakeTime
    @State private var sleepAmount: Double = 8.0
    @State private var coffeeAmount: Int = 1
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showingAlert: Bool = false
    
    // MARK: - Properties
    static var defaultWakeTime: Date {
        var components: DateComponents = .init()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
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
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    // MARK: - Public and Internal Methods
    func calculateBedTime() {
        do {
            let config: MLModelConfiguration = .init()
            let model: SleepCalculator = try .init(configuration: config)
            
            let components: DateComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour: Int = (components.hour ?? 0) * 60 * 60
            let minute: Int = (components.minute ?? 0) * 60
            
            let prediction: SleepCalculatorOutput = try model.prediction(
                wake: Double(hour + minute),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount)
            )
            
            let sleepTime: Date = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
        }
        
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
