//
//  ContentView.swift - contains initial UI for program
//  WeSplit
//
//  Created by Evan Tilley on 12/27/19.
//  Copyright © 2019 Evan Tilley. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //when @State property changes UI reloaded
    @State private var checkAmount = ""
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0 //if nil, default is 0
        
        let tipValue = orderAmount/100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal/peopleCount
        return amountPerPerson
    }
    var totalAmount: Double{
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount/100 * tipSelection
        let grandTotal = orderAmount + tipValue
        return grandTotal
    }
    //var peopleCount =
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    //checkAmount updates based on what user types
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people:", selection: $numberOfPeople){
                        ForEach(2..<100) { number in
                            Text("\(number) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")){
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(0 ..< tipPercentages.count){ number in
                            Text("\(self.tipPercentages[number])%")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")){
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Total amount (with tip)")){
                    Text("Total Amount: $\(totalAmount, specifier: "%.2f")")
                }
            }
        .navigationBarTitle("WeSplit")
        }
    }
}

//this piece of code is for you to look at preview on canvas
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
