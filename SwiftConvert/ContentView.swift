//
//  ContentView.swift
//  Swift
//
//  Created by Emir SARI on 15.11.2019.
//  Copyright © 2019 Emir SARI. All rights reserved.
//
//  Temperature conversion

import SwiftUI

struct ContentView: View {
    @State private var temperatureBaseType = 0
    @State private var temperatureConvertType = 1
    @State private var dataInput = ""
    
    let celsius = UnitTemperature.celsius
    let fahrenheit = UnitTemperature.fahrenheit
    let kelvin = UnitTemperature.kelvin
    let temperatureTypeArray = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var convertedResult: String {
        var input: Measurement<UnitTemperature>
        var convertedResult: Measurement<UnitTemperature>
        
        if temperatureBaseType == 0 {
            input = Measurement(value: Double(dataInput) ?? 0, unit: celsius)
            convertedResult = input.converted(to: kelvin)
        } else if temperatureBaseType == 1 {
            input = Measurement(value: Double(dataInput) ?? 0, unit: fahrenheit)
            convertedResult = input.converted(to: kelvin)
        } else {
            input = Measurement(value: Double(dataInput) ?? 0, unit: kelvin)
            convertedResult = input
        }
        
        switch temperatureConvertType {
        case 0:
            return "\(convertedResult.converted(to: celsius))"
        case 1:
            return "\(convertedResult.converted(to: fahrenheit))"
        default:
            return "\(convertedResult)"
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input Data")) {
                    Picker("Unit type", selection: $temperatureBaseType) {
                        ForEach(0 ..< temperatureTypeArray.count) {
                            Text(self.temperatureTypeArray[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    TextField("Enter data", text: $dataInput)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Output Data")) {
                    Picker("Unit type", selection: $temperatureConvertType) {
                        ForEach(0 ..< temperatureTypeArray.count) {
                            Text(self.temperatureTypeArray[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Result")) {
                    if dataInput != "" {
                        Text(convertedResult)
                    } else {
                        Text("Enter data to view conversion result")
                    }
                }
                Section {
                    Button("Copy") {
                        UIPasteboard.general.string = self.convertedResult
                        print("Result copied to clipboard!")
                    }.foregroundColor(Color.green)
                    Button("Clear") {
                        self.dataInput = ""
                    }.foregroundColor(Color.red)
                }
            }
            .navigationBarTitle("SwiftConvert")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
