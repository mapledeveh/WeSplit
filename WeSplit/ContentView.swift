//
//  ContentView.swift
//  WeSplit
//
//  Created by Alex Nguyen on 2023-04-27.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    func moneyFormatter() -> FloatingPointFormatStyle<Double>.Currency {
        .currency(code: Locale.current.currency?.identifier ?? "CAD")
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
      
    var grandTotal: Double {
        // grandtotal = tip amount + bill amount
        return Double(tipPercentage) / 100 * billAmount + billAmount
    }
    
    var amountPerPerson: Double {
        return grandTotal / Double(numberOfPeople + 2)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $billAmount, format: moneyFormatter())
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<21) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                }
                
                Section {
                    Picker("Choose Tip Percentage", selection: $tipPercentage) {
//                        ForEach(Array(stride(from: 0, to: 101, by: 5)), id: \.self) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.navigationLink)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(grandTotal, format: moneyFormatter())
                } header: {
                    Text("Total bill amount after tip")
                }
                
                Section {
                    Text(amountPerPerson, format: moneyFormatter())
                } header: {
                    Text("Each person pays")
                }
                .foregroundColor(tipPercentage == 0 ? .red : .black)
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
